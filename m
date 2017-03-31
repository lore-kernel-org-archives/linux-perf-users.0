From: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2] Allow user probes on versioned symbols
Date: Fri, 31 Mar 2017 08:19:15 -0600
Message-ID: <f0994cd1-ac91-078b-f5f9-6a3dee79cf17@gmail.com>
References: <7938e6cb-ed96-5d47-f0ae-02490eaebfe5@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36369 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754687AbdCaOTR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 31 Mar 2017 10:19:17 -0400
In-Reply-To: <7938e6cb-ed96-5d47-f0ae-02490eaebfe5@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: pc@us.ibm.com, LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

On 3/30/17 11:00 AM, Paul Clarke wrote:
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 4f9a71c..90342ee 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -330,6 +330,27 @@ int __weak arch__compare_symbol_names(const char
> *namea, const char *nameb)
>      return strcmp(namea, nameb);
>  }
>  
> +int map__compare_symbol_names(const char *namea, const char *nameb)
> +{
> +    int rc;
> +    const char *namea_versioning, *nameb_versioning;
> +
> +    namea_versioning = strstr(namea,"@@");
> +    if (namea_versioning)
> +        namea = strndup(namea,namea_versioning-namea);
> +
> +    nameb_versioning = strstr(nameb,"@@");
> +    if (nameb_versioning)
> +        nameb = strndup(nameb,nameb_versioning-nameb);
> +
> +    rc = arch__compare_symbol_names(namea, nameb);
> +
> +    if (namea_versioning) free((void *)namea);
> +    if (nameb_versioning) free((void *)nameb);

free() should be on the next line. Otherwise LGTM

Reviewed-by: David Ahern <dsahern@gmail.com>
