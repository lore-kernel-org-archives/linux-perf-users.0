From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] RFC perf test 14 add platform dependency
Date: Fri, 16 Jun 2017 13:08:17 -0300
Message-ID: <20170616160817.GD3645@kernel.org>
References: <20170613090937.72899-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbdFPQIV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2017 12:08:21 -0400
Content-Disposition: inline
In-Reply-To: <20170613090937.72899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: jolsa@redhat.com, linux-perf-users@vger.kernel.org

Em Tue, Jun 13, 2017 at 11:09:37AM +0200, Thomas Richter escreveu:
> This is a proposal to add platform dependency into the
> test case 14 (perf_event_attr). It is based on a suggestion from
> Jiri Olsa.
> Add a new optional attribute named 'machine' in the [config] section
> of the test case file. It is a comma separated list of architecture
> names this test can be executed on. For example:
> 
> machine = x86_64,alpha,ppc

Looks ok, Jiri?

- Arnaldo
 
> If this attribute is missing the test is executed on any platform.
> This does not break the current setup.
> The values listed for this attribute should be identical to
> uname -m output.
> If the list starts with an exclamation mark (!) the comparison is
> inverted, for example for
> 
> machine = !s390x,ppc
> 
> the test is not executed on s390x or ppc platforms.
> The exclamation mark must be at the beginnning of the list.
> 
> Here is an example debug output:
> [root@s35lp76]# fgrep machine tests/attr/test-stat-C2
> machine = x86_64,alpha,ppc
> [root@s35lp76]# PERF_TEST_ATTR=/tmp /usr/bin/python2 ./tests/attr.py \
>   -d ./tests/attr/ -p ./perf -vvvvv -t test-stat-C1
> 
> provides the following output:
> 
> running './tests/attr//test-stat-C1'
> test executed only on 'x86_64,alpha,ppc' <--- new
>   loading expected events
>     Event event:base-stat
>       fd = 1
>       group_fd = -1
>       .....
> skipped [s390x] './tests/attr//test-stat-C1' <--- new
> 
> The test is skipped with return code 0.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/attr.py | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
> index d0242d8..6e71d52 100644
> --- a/tools/perf/tests/attr.py
> +++ b/tools/perf/tests/attr.py
> @@ -30,6 +30,13 @@ class Fail(Exception):
>      def getMsg(self):
>          return '\'%s\' - %s' % (self.test.path, self.msg)
>  
> +class Notest(Exception):
> +    def __init__(self, test, arch):
> +        self.arch = arch
> +        self.test = test
> +    def getMsg(self):
> +        return '[%s] \'%s\'' % (self.arch, self.test.path)
> +
>  class Unsup(Exception):
>      def __init__(self, test):
>          self.test = test
> @@ -112,6 +119,7 @@ class Event(dict):
>  #     'command' - perf command name
>  #     'args'    - special command arguments
>  #     'ret'     - expected command return value (0 by default)
> +#     'machine' - machine specific test
>  #
>  # [eventX:base]
>  #   - one or multiple instances in file
> @@ -134,6 +142,12 @@ class Test(object):
>          except:
>              self.ret  = 0
>  
> +        try:
> +            self.machine  = parser.get('config', 'machine')
> +            log.warning("test limitation '%s'" % self.machine)
> +        except:
> +            self.machine  = ''
> +
>          self.expect   = {}
>          self.result   = {}
>          log.debug("  loading expected events");
> @@ -145,6 +159,30 @@ class Test(object):
>          else:
>              return True
>  
> +    def skip_test(self, arch):
> +        # If architecture not set always run test
> +        if self.machine == '':
> +            return False
> +
> +        # Allow multiple values in assignment separated by ','
> +        machine_list = self.machine.split(',')
> +
> +        # Handle negated list such as !s390x,ppc
> +        if machine_list[0][0] == '!':
> +            machine_list[0] = machine_list[0][1:]
> +            log.warning("excluded machine_list %s" % machine_list)
> +            for machine_item in machine_list:
> +                # log.warning("test for %s arch is %s" % (machine_item, arch))
> +                if machine_item == arch:
> +                    return True
> +            return False
> +
> +        for machine_item in machine_list:
> +            # log.warning("test for %s arch is %s" % (machine_item, arch))
> +            if machine_item == arch:
> +                return False
> +        return True
> +
>      def load_events(self, path, events):
>          parser_event = ConfigParser.SafeConfigParser()
>          parser_event.read(path)
> @@ -168,6 +206,11 @@ class Test(object):
>              events[section] = e
>  
>      def run_cmd(self, tempdir):
> +        junk1, junk2, junk3, junk4, arch = (os.uname())
> +
> +        if self.skip_test(arch):
> +            raise Notest(self, arch)
> +
>          cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
>                self.perf, self.command, tempdir, self.args)
>          ret = os.WEXITSTATUS(os.system(cmd))
> @@ -267,6 +310,8 @@ def run_tests(options):
>              Test(f, options).run()
>          except Unsup, obj:
>              log.warning("unsupp  %s" % obj.getMsg())
> +        except Notest, obj:
> +            log.warning("skipped %s" % obj.getMsg())
>  
>  def setup_log(verbose):
>      global log
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
