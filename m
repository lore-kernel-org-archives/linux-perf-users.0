Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D7F21E3BB
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161788; cv=none; b=tO9s0bjcxHNT+fbE5g0EjX5tDF/fMX2EWmius7syxr/dxefdAcQoOeYT3BISUjY9vw/jkehDFs7JOai3ZgZNX1p+NyjdL3Jx1x73fxDtkNRUp6hTxfKgD6q+xP+VfphSWrbG7GZxbWEBees18DphW0N2JhHQFvfNtQIqsTZNswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161788; c=relaxed/simple;
	bh=KdHbBVm5ErO0GQ0UchWd3IBYkI0vSVeGj1gFetER+ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EazRejhDm9Gw2SYmXwtIEo3HiF4z8ZPQ+TWioG/AjCoxo58tqm2up1Yqr/RXiaMPiye5jQ4kD9yYV8fISDgF5FkNvT+HA4U3R6kg9LAOqwqGWQK5qkRGSINalB3MoOe8w4rVdxWszyUJdqMlK+tYzIICgxUCRBWj4uVV5WXhrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A951FEC;
	Thu, 17 Oct 2024 03:43:34 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666D23F71E;
	Thu, 17 Oct 2024 03:43:03 -0700 (PDT)
Message-ID: <32a15b07-9aab-456a-a484-e15309a4cdf7@arm.com>
Date: Thu, 17 Oct 2024 11:43:01 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 1/2] Add map_pgoff to python dictionary
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <c0ca69f04ba93f1d05d753a3adc28ad9a09d34fe.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <c0ca69f04ba93f1d05d753a3adc28ad9a09d34fe.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 18:17, Steve Clevenger wrote:> 
> Add map_pgoff parameter to python dictionary so it can be seen by the
> python script.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>

Sorry for late replying. LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>   tools/perf/util/scripting-engines/trace-event-python.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index d7183134b669..367132b3a51a 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -793,7 +793,8 @@ static int set_regs_in_dict(PyObject *dict,
>   static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>                              const char *dso_field, const char *dso_bid_field,
>                              const char *dso_map_start, const char *dso_map_end,
> -                           const char *sym_field, const char *symoff_field)
> +                           const char *sym_field, const char *symoff_field,
> +                           const char *map_pgoff)
>   {
>          char sbuild_id[SBUILD_ID_SIZE];
> 
> @@ -809,6 +810,8 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>                          PyLong_FromUnsignedLong(map__start(al->map)));
>                  pydict_set_item_string_decref(dict, dso_map_end,
>                          PyLong_FromUnsignedLong(map__end(al->map)));
> +               pydict_set_item_string_decref(dict, map_pgoff,
> +                       PyLong_FromUnsignedLongLong(al->map->pgoff));
>          }
>          if (al->sym) {
>                  pydict_set_item_string_decref(dict, sym_field,
> @@ -895,7 +898,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>          pydict_set_item_string_decref(dict, "comm",
>                          _PyUnicode_FromString(thread__comm_str(al->thread)));
>          set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
> -                       "symbol", "symoff");
> +                       "symbol", "symoff", "map_pgoff");
> 
>          pydict_set_item_string_decref(dict, "callchain", callchain);
> 
> @@ -920,7 +923,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>                          PyBool_FromLong(1));
>                  set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
>                                  "addr_dso_map_start", "addr_dso_map_end",
> -                               "addr_symbol", "addr_symoff");
> +                               "addr_symbol", "addr_symoff", "addr_map_pgoff");
>          }
> 
>          if (sample->flags)
> --
> 2.44.0
> 
