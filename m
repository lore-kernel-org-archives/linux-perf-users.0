Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707B481248;
	Wed,  3 Jun 2026 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514505; cv=none; b=J9B5SLSu1/VxftLnNz3VgpKGrSAhF8lhz9puPbWR9ynOeh4UvfQDb07DNMwOGYDqV/5Dgm+XYh4/tvb6F4IzMznlHdLf9qObliT6jZZ9vTfaCxuSFuTdlxL1V08m3SGyB/NWtc3ObY6Fdl8cS18Ruwx5vvhws5fkdjabseqTwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514505; c=relaxed/simple;
	bh=lb8Z5BjDrTa2yy5/cYk1wUZGDvnAZCM4gkw7mbKqBGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap68x4v+V6ynex+cECPgA25HKl1OrQ5eUYTRBwHEZ1P5HhlOc/Ts3lOtwa5fZptmfLtnWMQs/QD6tlQUHaRnNUY8djs7e0RcMXzXZQvWvC27y4pJ1Xs03CoZm+kXnfCbfJWGTDYig5C2pG5oDSiOpbTDuAzVg2raEhtdaw2UTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRi/bsXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRi/bsXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B41F00893;
	Wed,  3 Jun 2026 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780514504;
	bh=GOQrXSl4xXPviDTu6jc900ukeDv1QAv2FTmczDd1Eyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nRi/bsXdChw5GPtf78tSKyX1XL2bRl/yMacTaxWmV/4rCVhwBWXHOyCxwUCqp5lZd
	 XU9dn23pYbR3qpN0GVreFO093uwzDu8WzrQDgBze7NbtEcTqsjh5ymnlaD2SD9UkQe
	 NvucyIJeTQKPpZCYiUGZLBq/GjzPAVQO1hzlYSEPm/POWD0IA+H06djM7HqWL4tAxH
	 E2jOzgDFv4BWUuWkRZf5ybZZ5XpNnh0FbE33Q6Q6AQq0Kv7oV1kFrBSFY3luvqDIEe
	 yRWwQKcb7gNAmNRpM+BJcWzUql4iIZkvISXEFU1Ua68pwXLxLnXJ+qjIMkJAvOwVZk
	 ZHXJdTes3M9aA==
Date: Wed, 3 Jun 2026 16:21:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/18] perf test: Add workload-ctl option
Message-ID: <aiB-w5V1oQl4a0Sy@x1>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:44PM +0100, James Clark wrote:
> Add a --workload-ctl=fifo:ctl-fifo[,ack-fifo] option for 'perf test
> -w'. When set, run_workload() opens the named FIFO, writes enable before
> invoking the builtin workload, writes disable before returning, and
> waits for ack responses when an ack FIFO is provided to ensure that the
> workload doesn't run until the events are enabled.
> 
> This can be used to limit the scope of the recording to only the
> workload execution and avoid recording Perf setup and teardown code if
> Perf record is started with events disabled (-D 1).

I see no mention to the equivalent in 'perf record', from its man page:

----------------------------------------------------------------------
--control=fifo:ctl-fifo[,ack-fifo]::
--control=fd:ctl-fd[,ack-fd]::
ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
Listen on ctl-fd descriptor for command to control measurement.

Available commands:

  - 'enable'           : enable events
  - 'disable'          : disable events
  - 'enable name'      : enable event 'name'
  - 'disable name'     : disable event 'name'
  - 'snapshot'         : AUX area tracing snapshot).
  - 'stop'             : stop perf record
  - 'ping'             : ping
  - 'evlist [-v|-g|-F] : display all events

                         -F  Show just the sample frequency used for each event.
                         -v  Show all fields.
                         -g  Show event group information.
----------------------------------------------------------------------

Can this be shared code?

- Arnaldo
 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/Documentation/perf-test.txt |   6 ++
>  tools/perf/tests/builtin-test.c        | 184 ++++++++++++++++++++++++++++++++-
>  2 files changed, 188 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
> index 32da0d1fa86a..1faf30d4a7be 100644
> --- a/tools/perf/Documentation/perf-test.txt
> +++ b/tools/perf/Documentation/perf-test.txt
> @@ -69,3 +69,9 @@ OPTIONS
>  
>  --list-workloads::
>  	List the available workloads to use with -w/--workload.
> +
> +--workload-ctl=fifo:ctl-fifo[,ack-fifo]::
> +	Write 'enable' to ctl-fifo before running the workload and 'disable'
> +	before returning. If ack-fifo is provided, the workload runner waits for
> +	an 'ack' response after each command. This scopes the recording to only
> +	the workload if used with 'perf record -D 1 --control ...'.
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index f2c135891477..d5df3efdce3b 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -50,6 +50,7 @@ static bool sequential;
>  static unsigned int runs_per_test = 1;
>  const char *dso_to_test;
>  const char *test_objdump_path = "objdump";
> +static const char *workload_control;
>  
>  /*
>   * List of architecture specific tests. Not a weak symbol as the array length is
> @@ -161,6 +162,11 @@ static struct test_workload *workloads[] = {
>  #endif
>  };
>  
> +struct workload_control {
> +	int ctl_fd;
> +	int ack_fd;
> +};
> +
>  #define workloads__for_each(workload) \
>  	for (unsigned i = 0; i < ARRAY_SIZE(workloads) && ({ workload = workloads[i]; 1; }); i++)
>  
> @@ -711,13 +717,185 @@ static int workloads__fprintf_list(FILE *fp)
>  	return printed;
>  }
>  
> +static int perf_control_open_fifo(struct workload_control *ctl, const char *str)
> +{
> +	char *s, *p;
> +	int ret;
> +
> +	if (strncmp(str, "fifo:", 5))
> +		return -EINVAL;
> +
> +	str += 5;
> +	if (!*str || *str == ',')
> +		return -EINVAL;
> +
> +	s = strdup(str);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	p = strchr(s, ',');
> +	if (p)
> +		*p = '\0';
> +
> +	ctl->ctl_fd = open(s, O_WRONLY | O_CLOEXEC);
> +	if (ctl->ctl_fd < 0) {
> +		ret = -errno;
> +		pr_err("Failed to open workload control FIFO '%s': %m\n", s);
> +		free(s);
> +		return ret;
> +	}
> +
> +	if (p && *++p) {
> +		ctl->ack_fd = open(p, O_RDONLY | O_CLOEXEC);
> +		if (ctl->ack_fd < 0) {
> +			ret = -errno;
> +			pr_err("Failed to open workload control ack FIFO '%s': %m\n", p);
> +			close(ctl->ctl_fd);
> +			ctl->ctl_fd = -1;
> +			free(s);
> +			return ret;
> +		}
> +	}
> +
> +	free(s);
> +	return 0;
> +}
> +
> +static int perf_control_open(struct workload_control *ctl)
> +{
> +	int ret;
> +
> +	if (!workload_control)
> +		return 0;
> +
> +	ret = perf_control_open_fifo(ctl, workload_control);
> +
> +	if (ret == -EINVAL) {
> +		pr_err("Unsupported workload control spec '%s', expected fifo:ctl-fifo[,ack-fifo]\n",
> +			workload_control);
> +	}
> +
> +	return ret;
> +}
> +
> +static void perf_control_close(struct workload_control *ctl)
> +{
> +	if (ctl->ctl_fd >= 0) {
> +		close(ctl->ctl_fd);
> +		ctl->ctl_fd = -1;
> +	}
> +	if (ctl->ack_fd >= 0) {
> +		close(ctl->ack_fd);
> +		ctl->ack_fd = -1;
> +	}
> +}
> +
> +static int perf_control_write_cmd(int fd, const char *cmd)
> +{
> +	size_t len = strlen(cmd);
> +	ssize_t ret;
> +
> +	while (len) {
> +		ret = write(fd, cmd, len);
> +		if (ret < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			pr_err("Failed to write perf control command '%s': %m\n", cmd);
> +			return -1;
> +		}
> +
> +		if (!ret) {
> +			pr_err("Failed to write perf control command '%s': short write\n", cmd);
> +			return -1;
> +		}
> +
> +		cmd += ret;
> +		len -= ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int perf_control_read_ack(int fd)
> +{
> +	char buf[16];
> +	ssize_t ret;
> +
> +	do {
> +		ret = read(fd, buf, sizeof(buf) - 1);
> +	} while (ret < 0 && errno == EINTR);
> +
> +	if (ret < 0) {
> +		pr_err("Failed to read perf control ack: %m\n");
> +		return -1;
> +	}
> +
> +	if (!ret) {
> +		pr_err("Unexpected EOF while reading perf control ack\n");
> +		return -1;
> +	}
> +
> +	buf[ret] = '\0';
> +	for (ssize_t i = 0; i < ret; i++) {
> +		if (buf[i] == '\n' || buf[i] == '\0') {
> +			buf[i] = '\0';
> +			break;
> +		}
> +	}
> +
> +	if (strcmp(buf, "ack")) {
> +		pr_err("Unexpected perf control ack: %s\n", buf);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int perf_control_send(struct workload_control *ctl, const char *cmd)
> +{
> +	if (ctl->ctl_fd < 0)
> +		return 0;
> +
> +	if (perf_control_write_cmd(ctl->ctl_fd, cmd))
> +		return -1;
> +
> +	if (ctl->ack_fd >= 0 && perf_control_read_ack(ctl->ack_fd))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int run_workload(const char *work, int argc, const char **argv)
>  {
>  	struct test_workload *twl;
>  
>  	workloads__for_each(twl) {
> -		if (!strcmp(twl->name, work))
> -			return twl->func(argc, argv);
> +		struct workload_control ctl = {
> +			.ctl_fd = -1,
> +			.ack_fd = -1,
> +		};
> +		int control_ret, ret;
> +
> +		if (strcmp(twl->name, work))
> +			continue;
> +
> +		ret = perf_control_open(&ctl);
> +		if (ret)
> +			return ret;
> +
> +		if (perf_control_send(&ctl, "enable\n")) {
> +			perf_control_close(&ctl);
> +			return -1;
> +		}
> +
> +		ret = twl->func(argc, argv);
> +
> +		control_ret = perf_control_send(&ctl, "disable\n");
> +		perf_control_close(&ctl);
> +		if (control_ret)
> +			return -1;
> +
> +		return ret;
>  	}
>  
>  	pr_info("No workload found: %s\n", work);
> @@ -799,6 +977,8 @@ int cmd_test(int argc, const char **argv)
>  	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
>  		     "Run each test the given number of times, default 1"),
>  	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
> +	OPT_STRING(0, "workload-ctl", &workload_control, "fifo:ctl-fifo[,ack-fifo]",
> +		   "Write enable to the fifo just before running the workload and disable after, with optional ack from ack-fifo"),
>  	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
>  	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>  	OPT_STRING(0, "objdump", &test_objdump_path, "path",
> 
> -- 
> 2.34.1
