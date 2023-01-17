Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D5C63797
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Jan 2023 15:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAQPTP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjAQPS0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Jan 2023 10:18:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48840BEB
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jan 2023 07:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673968654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RbQc1x0le2uzXYwwuT+ggffbpp+gPJWmHQBbJWhtAw=;
        b=VtV5x9cgrs2M/fxrx94lK4txmepBozzpoogBNN4Zh7x9rSYbTHnky9BiMgNeC9EoJyCm0w
        7M5tPDTskOO8f273U8/L/PiSmYHK+TTUxhtkAoJuh7ByreCNTfJWCsOyhdl/7wYS8YLR6X
        Ng+hAAu0KWnBqSBL0i7R88J1BtNaz5E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-o04TTi8_PHyYHQIhQov4mw-1; Tue, 17 Jan 2023 10:17:33 -0500
X-MC-Unique: o04TTi8_PHyYHQIhQov4mw-1
Received: by mail-ed1-f70.google.com with SMTP id t17-20020a056402525100b0049e0d2dd9b1so4634936edd.11
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jan 2023 07:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RbQc1x0le2uzXYwwuT+ggffbpp+gPJWmHQBbJWhtAw=;
        b=lg2+iiDc95SVLkE/28UCrknPcAFwbFv8+lW90q9JG7rVBD+anorUy8JtC7yl8SAh9L
         MLltgpdAiMkBlCtZ++Jyrc5sdMa+H4qRgRuen3yJrSKNcO8XcIvLAfnsjdHSTo9eTZs4
         3oQdpf33+lrNb1m13pwikvg70F/yIl4YuzuNx3kTo9KZGRPOJYNISyxM36kHx1tM96Ck
         jN/yhhL9/c75towNQwt0/xcNULD8xnlGnDdzw87N7rdaviO55RCxu8CViJNHV6Ackumq
         9ib/p99+ZDd3blWSrDlvViVLGqgryVOixynGE3/bv9RWI1xNqlJb4nUjE+7RvjAVtEhS
         +0hA==
X-Gm-Message-State: AFqh2kqBLdIptfSGt2JFaLi/efs9yhfjzy8iWXJ0pyLeUfDCT++cVlgj
        GQJ5EMPAPYGnb/CKfmtWaV7fVZngJl57S8wMPEhVxRlsIFYUARhN/O0gvIGRmPInrPjx3aD/Lnt
        +iA73cxjBO2tfyWKHF3BKF9K2V1425w==
X-Received: by 2002:a05:6402:602:b0:49d:f448:878c with SMTP id n2-20020a056402060200b0049df448878cmr11687937edv.2.1673968651128;
        Tue, 17 Jan 2023 07:17:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtBcBkMr6etlJY7aciZ5LLC6Z+mNUrynCjhZzcnY6umb0S/UV2EsJ3yrEpUlRyDdPM9z1i52Q==
X-Received: by 2002:a05:6402:602:b0:49d:f448:878c with SMTP id n2-20020a056402060200b0049df448878cmr11687903edv.2.1673968650747;
        Tue, 17 Jan 2023 07:17:30 -0800 (PST)
Received: from [192.168.31.129] (84-115-237-15.cable.dynamic.surfer.at. [84.115.237.15])
        by smtp.gmail.com with ESMTPSA id g11-20020a056402428b00b004722d7e8c7csm12848623edc.14.2023.01.17.07.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 07:17:30 -0800 (PST)
Message-ID: <2568dad8-88b4-ebf9-3013-73cc6becdc1c@redhat.com>
Date:   Tue, 17 Jan 2023 16:17:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] perf script flamegraph: Avoid d3-flame-graph package
 dependency
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Martin Spier <spiermar@gmail.com>,
        Brendan Gregg <brendan@intel.com>
References: <20230112220024.32709-1-irogers@google.com>
Content-Language: en-US
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
In-Reply-To: <20230112220024.32709-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12.01.23 23:00, Ian Rogers wrote:
> Currently flame graph generation requires a d3-flame-graph template to
> be installed. Unfortunately this is hard to come by for things like
> Debian [1]. If the template isn't installed then ask if it should be
> downloaded from jsdelivr CDN. The downloaded HTML file is validated
> against an md5sum. If the download fails, generate a minimal flame
> graph with the javascript coming from links to jsdelivr CDN.
> 
> v2. Change the warning to a prompt about downloading and add the
>      --allow-download command line flag. Add an md5sum check for the
>      downloaded HTML.
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thank you for the changes. I've tested v2 with:

* d3-flame-graph package installed
* template not installed, download template from jsdelivr
* download from jsdelivr, with --allow-download
* invalid checksum
* unreachable jsdelivr, creating a minimal template

Everything works great except when I'm invoking "perf script flamegraph 
-a -F 99 sleep 10" (combining perf report + perf script):

[root@agerstmayr-thinkpad tmp]# perf script flamegraph -a -F 99 sleep 10
------------------------------------------------------------
[...]
------------------------------------------------------------
Warning: Flame Graph template 
'/usr/share/d3-flame-graph/d3-flamegraph-base.html'
does not exist. To avoid this please install a package such as the
js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
graph template (--template PATH) or use another output format (--format
FORMAT).
Do you wish to download a template from cdn.jsdelivr.net? (this warning 
can be suppressed with --allow-download) [yn] Traceback (most recent 
call last):
   File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 157, 
in trace_end
     s = input("Do you wish to download a template from 
cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) 
[yn] ").lower()
 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
OSError: [Errno 9] Bad file descriptor
Fatal Python error: handler_call_die: problem in Python trace event handler
Python runtime state: initialized

Current thread 0x00007ff4053a3cc0 (most recent call first):
   <no Python frame>

Extension modules: systemd._journal, systemd._reader, systemd.id128 
(total: 3)
/usr/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3: 
2135491 Aborted                 (core dumped) perf script -s 
"$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"


iirc when running "perf script flamegraph" the perf.data gets piped to 
stdin of the flamegraph script, so we can't ask the user in this case. 
You can check this condition with `self.args.input == "-". Not sure 
what's the best action in this case, maybe just exit?


Cheers,
Andreas


> ---
>   tools/perf/scripts/python/flamegraph.py | 96 +++++++++++++++++++------
>   1 file changed, 74 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index b6af1dd5f816..086619053e4e 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -19,12 +19,34 @@
>   # pylint: disable=missing-function-docstring
>   
>   from __future__ import print_function
> -import sys
> -import os
> -import io
>   import argparse
> +import hashlib
> +import io
>   import json
> +import os
>   import subprocess
> +import sys
> +import urllib.request
> +
> +minimal_html = """<head>
> +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> +</head>
> +<body>
> +  <div id="chart"></div>
> +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> +  <script type="text/javascript">
> +  const stacks = [/** @flamegraph_json **/];
> +  // Note, options is unused.
> +  const options = [/** @options_json **/];
> +
> +  var chart = flamegraph();
> +  d3.select("#chart")
> +        .datum(stacks[0])
> +        .call(chart);
> +  </script>
> +</body>
> +"""
>   
>   # pylint: disable=too-few-public-methods
>   class Node:
> @@ -50,16 +72,6 @@ class FlameGraphCLI:
>           self.args = args
>           self.stack = Node("all", "root")
>   
> -        if self.args.format == "html" and \
> -                not os.path.isfile(self.args.template):
> -            print("Flame Graph template {} does not exist. Please install "
> -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> -                  "package, specify an existing flame graph template "
> -                  "(--template PATH) or another output format "
> -                  "(--format FORMAT).".format(self.args.template),
> -                  file=sys.stderr)
> -            sys.exit(1)
> -
>       @staticmethod
>       def get_libtype_from_dso(dso):
>           """
> @@ -128,16 +140,52 @@ class FlameGraphCLI:
>               }
>               options_json = json.dumps(options)
>   
> +            template_md5sum = None
> +            if self.args.format == "html":
> +                if os.path.isfile(self.args.template):
> +                    template = f"file://{self.args.template}"
> +                else:
> +                    if not self.args.allow_download:
> +                        print(f"""Warning: Flame Graph template '{self.args.template}'
> +does not exist. To avoid this please install a package such as the
> +js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
> +graph template (--template PATH) or use another output format (--format
> +FORMAT).""",
> +                              file=sys.stderr)
> +                        s = None
> +                        while s != "y" and s != "n":
> +                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
> +                        if s == "n":
> +                            quit()
> +                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> +                    template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
> +
>               try:
> -                with io.open(self.args.template, encoding="utf-8") as template:
> -                    output_str = (
> -                        template.read()
> -                        .replace("/** @options_json **/", options_json)
> -                        .replace("/** @flamegraph_json **/", stacks_json)
> -                    )
> -            except IOError as err:
> -                print("Error reading template file: {}".format(err), file=sys.stderr)
> -                sys.exit(1)
> +                with urllib.request.urlopen(template) as template:
> +                    output_str = "".join([
> +                        l.decode("utf-8") for l in template.readlines()
> +                    ])
> +            except Exception as err:
> +                print(f"Error reading template {template}: {err}\n"
> +                      "a minimal flame graph will be generated", file=sys.stderr)
> +                output_str = minimal_html
> +                template_md5sum = None
> +
> +            if template_md5sum:
> +                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
> +                if download_md5sum != template_md5sum:
> +                    s = None
> +                    while s != "y" and s != "n":
> +                        s = input(f"""Unexpected template md5sum.
> +{download_md5sum} != {template_md5sum}, for:
> +{output_str}
> +continue?[yn] """).lower()
> +                    if s == "n":
> +                        quit()
> +
> +            output_str = output_str.replace("/** @options_json **/", options_json)
> +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> +
>               output_fn = self.args.output or "flamegraph.html"
>           else:
>               output_str = stacks_json
> @@ -172,6 +220,10 @@ if __name__ == "__main__":
>                           choices=["blue-green", "orange"])
>       parser.add_argument("-i", "--input",
>                           help=argparse.SUPPRESS)
> +    parser.add_argument("--allow-download",
> +                        default=False,
> +                        action="store_true",
> +                        help="allow unprompted downloading of HTML template")
>   
>       cli_args = parser.parse_args()
>       cli = FlameGraphCLI(cli_args)

-- 
Red Hat Austria GmbH, Registered seat: A-1200 Vienna, Millennium Tower, 
26.floor, Handelskai 94-96, Austria
Commercial register: Commercial Court Vienna, FN 479668w

