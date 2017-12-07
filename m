From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] fixup! perf: introduce errno_to_name() function
Date: Thu, 7 Dec 2017 09:37:17 +0100
Message-ID: <20171207083717.GD4889@linux.vnet.ibm.com>
References: <1512635281-20733-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512635281-20733-3-git-send-email-brueckner@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751000AbdLGIhY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Dec 2017 03:37:24 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB78YxHe124276
        for <linux-perf-users@vger.kernel.org>; Thu, 7 Dec 2017 03:37:24 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2epyhexa4d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2017 03:37:23 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 08:37:21 -0000
Content-Disposition: inline
In-Reply-To: <1512635281-20733-3-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org

Hi Arnaldo,

just looking through my posting and just need a fixup for one hunk.  Please
let me know whether I shall re-post the series again.  Sorry for this
inconvenience.

On Thu, Dec 07, 2017 at 09:28:00AM +0100, Hendrik Brueckner wrote:
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[...]
> @@ -1659,6 +1658,18 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
>  	return sample__fprintf_callchain(sample, 38, print_opts, &callchain_cursor, trace->output);
>  }
> 
> +static const char *errno_to_name(int err)
> +{
> +	switch (err) {
> +#define ERRNO_NAME_MAP(_err, _num) case _num: return #_err;
> +	ALL_ERRNO_NAME_MAPPINGS
> +#undef ONE_ERRNO_NAME


diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b7aef0f..04af6a1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1663,7 +1663,7 @@ static const char *errno_to_name(int err)
 	switch (err) {
 #define ERRNO_NAME_MAP(_err, _num) case _num: return #_err;
 	ALL_ERRNO_NAME_MAPPINGS
-#undef ONE_ERRNO_NAME
+#undef ERRNO_NAME_MAP
 	default:
 		return "(unknown)";
 		break;
