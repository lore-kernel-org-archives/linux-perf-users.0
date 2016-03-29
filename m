From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the
 perftool-testsuite
Date: Tue, 29 Mar 2016 14:19:47 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1603290212010.7107@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com> <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7> <20160327122435.GK4015@krava.sund.root.ku.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="684032-482910624-1459210422=:7107"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128AbcC2MTu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2016 08:19:50 -0400
In-Reply-To: <20160327122435.GK4015@krava.sund.root.ku.dk>
Content-ID: <alpine.LRH.2.20.1603291419280.7107@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--684032-482910624-1459210422=:7107
Content-Type: text/plain; CHARSET=ISO-8859-7; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.20.1603291419281.7107@Rudolf-RHEL-7>

On Sun, 27 Mar 2016, Jiri Olsa wrote:
>
> got following compile error:
>
>  CC       tests/suite.o
> tests/suite.c: In function ¡test__suite¢:
> tests/suite.c:119:20: error: assignment makes integer from pointer without a cast [-Werror=int-conversion]
>  _tempdir_template = mkdtemp(tempdir_template);
>                    ^
> tests/suite.c:120:30: error: passing argument 2 of ¡setenv¢ makes pointer from integer without a cast [-Werror=int-conversion]
>  setenv("PERFSUITE_RUN_DIR", _tempdir_template, 1);
>                              ^
> In file included from tests/suite.h:6:0,
>                 from tests/suite.c:1:
> /usr/include/stdlib.h:584:12: note: expected ¡const char *¢ but argument is of type ¡char¢
> extern int setenv (const char *__name, const char *__value, int __replace)
>            ^
> cc1: all warnings being treated as errors
>
>
> moving on with attached patch

I noticed this error too and that's why I sent the mail with the following $subj:
"[PATCH 1/9] perf test: Adding an entry for the perftool-testsuite - CORRECT"

A stupid mistake, of course it must be a pointer.

Michael

>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/tests/suite.c b/tools/perf/tests/suite.c
> index 17f66107f34d..1561bec3a2e1 100644
> --- a/tools/perf/tests/suite.c
> +++ b/tools/perf/tests/suite.c
> @@ -108,7 +108,8 @@ int test__suite(int subtest __maybe_unused)
> 	int test_status = TEST_OK;
> 	char verbosity_str[2];
> 	int _verbose = (verbose > 9)? 9 : verbose;
> -	char tempdir_template[24], _tempdir_template;
> +	char tempdir_template[24];
> +	char *_tempdir_template;
>
> 	/* set verbosity according to perf-test command line switches */
> 	snprintf(verbosity_str, 2, "%i", _verbose);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--684032-482910624-1459210422=:7107--
