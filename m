Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190591C69C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834693; cv=none; b=pGCevpmIvbwCJthZTORvmZ3cilZzEcZiFxxUMDM4vS0gb2b13JHUeH1UgKbqm+4RM/xl7POni0Y9thp4Jriz0BAUUzc4Q0bnUpzANVq6n/EKphMws4dL1BbU5evDo6r2qHT4M/aZaZY98TjNlnZ7LQ8c0ifaaUbbXdJyJBhe28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834693; c=relaxed/simple;
	bh=LzfKmJ9XtO8zhQDfc5QmJbMAQXMQx7sEqOh+vP3I0hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKSTDgYFmWwF+fJ+gXJdrR5gtr9tbWL8UZAq6sCgkX5UAoiaxRNpSdXCIMMog3rhejXdR9/bl7oxuRuhEn3Ce+KAhM9vDS/OQclrzoZz66txt59myN+oA3MWGxsySt76tgoVEJzhTI4ie5dX9O+3NJXk9M54R98wPpa29L8vExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FC68DA7;
	Wed, 28 Aug 2024 01:45:17 -0700 (PDT)
Received: from [10.1.33.31] (PF4Q20KV.arm.com [10.1.33.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 100B63F762;
	Wed, 28 Aug 2024 01:44:49 -0700 (PDT)
Message-ID: <cfd4455b-9583-45dc-a723-ef67e0fc3457@arm.com>
Date: Wed, 28 Aug 2024 09:44:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] Add map pgoff to python dictionary based on
 MAPPING_TYPE
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
 <04a8a735c1a3794c64f1687fc8963d5713807b95.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <04a8a735c1a3794c64f1687fc8963d5713807b95.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2024 6:09 AM, Steve Clevenger wrote:
> 
> Add map_pgoff parameter to python dictionary so it can be seen by the
> python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
> the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
> map_pgoff value is directly added to the dictionary.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> ---
>  .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 6971dd6c231f..b8da0ea5e55c 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -798,7 +798,8 @@ static int set_regs_in_dict(PyObject *dict,
>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>                             const char *dso_field, const char *dso_bid_field,
>                             const char *dso_map_start, const char *dso_map_end,
> -                           const char *sym_field, const char *symoff_field)
> +                           const char *sym_field, const char *symoff_field,
> +                           const char *map_pgoff)
>  {
>         char sbuild_id[SBUILD_ID_SIZE];
> 
> @@ -814,6 +815,12 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>                         PyLong_FromUnsignedLong(map__start(al->map)));
>                 pydict_set_item_string_decref(dict, dso_map_end,
>                         PyLong_FromUnsignedLong(map__end(al->map)));
> +               if (al->map->mapping_type == MAPPING_TYPE__DSO)
> +                       pydict_set_item_string_decref(dict, map_pgoff,
> +                                       PyLong_FromUnsignedLongLong(al->map->pgoff));
> +               else
> +                       pydict_set_item_string_decref(dict, map_pgoff,
> +                               PyLong_FromUnsignedLongLong(0));

Indention is inconsistent. Please keep the same format.

>         }
>         if (al->sym) {
>                 pydict_set_item_string_decref(dict, sym_field,
> @@ -900,7 +907,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>         pydict_set_item_string_decref(dict, "comm",
>                         _PyUnicode_FromString(thread__comm_str(al->thread)));
>         set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
> -                       "symbol", "symoff");
> +                       "symbol", "symoff", "map_pgoff");
> 
>         pydict_set_item_string_decref(dict, "callchain", callchain);
> 
> @@ -925,7 +932,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>                         PyBool_FromLong(1));
>                 set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
>                                 "addr_dso_map_start", "addr_dso_map_end",
> -                               "addr_symbol", "addr_symoff");
> +                               "addr_symbol", "addr_symoff", "map_pgoff");

This dict variable is for data address parsing. For alignment the naming, here
can change it as "addr_map_pgoff"?

Please note, from my understanding, this renaming will not impact the
sequential change as the python script should only use the dso dict. Please
confirm at your side.

With above changes:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>         }
> 
>         if (sample->flags)
> --
> 2.25.1
> 
