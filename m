From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf tools: Add 'perf-config' command
Date: Fri, 10 Apr 2015 10:53:34 +0200
Message-ID: <20150410085334.GA31326@krava.brq.redhat.com>
References: <1428589591-22838-1-git-send-email-treeze.taeung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326AbbDJIxk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Apr 2015 04:53:40 -0400
Content-Disposition: inline
In-Reply-To: <1428589591-22838-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Taeung Song <treeze.taeung@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org

On Thu, Apr 09, 2015 at 11:26:30PM +0900, Taeung Song wrote:
> The perf configuration file contain many variables which can make
> the perf command's action more effective and more skilful.
> But looking through state of configuration is difficult and
> there's no knowing what kind of other variables except variables in perfconfig.example exist.
> So This patch adds 'perf-config' command with '--all' option and a document for it.

hi,
any chance the 'perf config -a' would display current config PLUS
all possible keys with their default values?  Like total overview
of the config options.. I mean all the options you described in
the doc.

While 'perf config' would display only those options you have
defined in the config file..

It could be part as next patch of course as it might need
more coding.

one nit below

thanks,
jirka

> 
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>  tools/perf/Build                            |   1 +
>  tools/perf/Documentation/perf-config.txt    | 433 ++++++++++++++++++++++++++++
>  tools/perf/Documentation/perfconfig.example |  65 ++++-
>  tools/perf/builtin-config.c                 |  68 +++++

SNIP

> +	return 0;
> +}
> +
> +int cmd_config(int argc, const char **argv, const char *prefix __maybe_unused)
> +{
> +	int ret = 0;
> +
> +	argc = parse_options(argc, argv, config_options, config_usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +	if (argc > 0) {
> +		if (strcmp(argv[0], "-") == 0) {
> +			pr_warning("  Error: '-' is not supported.\n");
> +			usage_with_options(config_usage, config_options);
> +		}
> +	}

for some reason you display error only for '-', and not for unknow argument

[jolsa@krava perf]$ ./perf config -
  Error: '-' is not supported.

 usage: perf config [options]

Action
    -a, --all             print all configurations

[jolsa@krava perf]$ ./perf config krava
[jolsa@krava perf]$ 
