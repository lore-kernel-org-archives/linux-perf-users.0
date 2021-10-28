Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F950C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 02:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353B660F39
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 02:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhJ1Cjv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 22:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhJ1Cju (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 22:39:50 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0AC061570;
        Wed, 27 Oct 2021 19:37:24 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id t201-20020a4a3ed2000000b002b8c98da3edso1642179oot.8;
        Wed, 27 Oct 2021 19:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Bsuam4tOUTAT9P3PVYXcOROPj8Vt2vjYUc+nth7NOgg=;
        b=NSfj38PeXdpHauANTgLSK8joncYGeMKYmrgNT9xux88wwXAxq0/0TlBGHPurpytiLu
         83b/1K2DoHGh2WxML1HQ8xvvLS3dDLg++cm+P1JW9l4NUpaxUsDDakmMT93rijDOisSN
         VJxTqumol0YfDGyvmX6n7xRtOtxq0pku7ePeTceP3QwmBx2vXSwou9kn1oMRKHX79IzG
         lc9pBHQ3FfJfrkjHOKIM4fmAVb7bTCrU9vT2O6oCjiGxL9OQo6c0a+VAEKq1xQwj9BXF
         FGlLXatDwRE91zsXtqI4AyX4CI+6DYSVYekzRPv2HDXEIJiQJPScBOikOKPqb3APOV5y
         9Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Bsuam4tOUTAT9P3PVYXcOROPj8Vt2vjYUc+nth7NOgg=;
        b=a13VaAO1fOSL8b7x6YkjYdAmLKAPlZHmZS26KwEZzJS5AzD1XaCz9PeTdqalsfJBAU
         gOVfX4j/e0NP4gdbMA7vSUz0TwhVWwkTiHQiTELHhKFgMHdPtFlnZcUwOxuDQOcJrndB
         0GtC/uQr155lMDEq5Yf5pwPrEOok4bPEsrBTRQhVSbGdjeSMXxK8mJzymKj5Bwvjx1sW
         lAgKQkrM1pgCrCAu/vEGY7NzMxigpLClgbloy5taHALcXUYO5X8JcRXwqRIEXhC0oxS2
         yLPf/enveUitapO89sRCubK3L1NYQUJNBGWrX0mNoOVWUNa6lYLBygcnMkL6rDZVw2+D
         EXNA==
X-Gm-Message-State: AOAM5331pAhfYdLaiALlRQGwpAC1hke/jH36a/gFT70CWIcliPYIpBjL
        PRE+d9cG9pcAR/IARkFWo9U=
X-Google-Smtp-Source: ABdhPJwhOT/hl/5Hpl/dneBsVLiyVuH41OonHsDU6CtVZFuepmap/0CkpMBAiS3XUpOaPccmCzeHmw==
X-Received: by 2002:a4a:c015:: with SMTP id v21mr1065299oop.17.1635388642641;
        Wed, 27 Oct 2021 19:37:22 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x8sm632617otg.31.2021.10.27.19.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 19:37:22 -0700 (PDT)
Date:   Wed, 27 Oct 2021 23:37:02 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
CC:     jolsa@redhat.com, michael@ellerman.id.au, eranian@google.com,
        mark.rutland@arm.com, namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_tools/perf=3A_Add_bitfiel?= =?US-ASCII?Q?d=5Fswap_to_handle_branch=5Fstack_endian_issue?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YXnr8xpltsVZPATC@kernel.org>
References: <20211016125059.691856-1-maddy@linux.ibm.com> <YXnr8xpltsVZPATC@kernel.org>
Message-ID: <FD195114-27C2-4F8F-B05E-2E9D5595C4EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On October 27, 2021 9:16:51 PM GMT-03:00, Arnaldo Carvalho de Melo <acme@k=
ernel=2Eorg> wrote:
>Em Sat, Oct 16, 2021 at 06:20:58PM +0530, Madhavan Srinivasan escreveu:
>> branch_stack struct has bit field definition which
>> produces different bit ordering for big/little endian=2E
>> Because of this, when branch_stack sample is collected
>> in a BE system and viewed/reported in a LE system, bit
>> fields of the branch stack are not presented properly=2E
>> To address this issue, a evsel__bitfield_swap_branch_stack()
>> is defined and introduced in evsel__parse_sample=2E
>>=20
>> Signed-off-by: Madhavan Srinivasan <maddy@linux=2Eibm=2Ecom>
>> ---
>> Changelog v1:
>> - Renamed function and macro
>> - Added comments in code
>

Please, run 'perf test' before submitting patches, it's not that difficult=
, please do so=2E

- Arnaldo

>[acme@quaco perf]$ perf test python
>19: 'import perf' in python                                         : FAI=
LED!
>[acme@quaco perf]$ perf test -v python
>Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF =
maps, etc
>19: 'import perf' in python                                         :
>--- start ---
>test child forked, pid 991284
>python usage test: "echo "import sys ; sys=2Epath=2Eappend('/tmp/build/pe=
rf/python'); import perf" | '/usr/bin/python3' "
>Traceback (most recent call last):
>  File "<stdin>", line 1, in <module>
>ImportError: /tmp/build/perf/python/perf=2Ecpython-39-x86_64-linux-gnu=2E=
so: undefined symbol: bigendian
>test child finished with -1
>---- end ----
>'import perf' in python: FAILED!
>[acme@quaco perf]$
>=20
>>  tools/perf/util/evsel=2Ec | 74 +++++++++++++++++++++++++++++++++++++++=
--
>>  tools/perf/util/evsel=2Eh | 13 ++++++++
>>  2 files changed, 85 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/tools/perf/util/evsel=2Ec b/tools/perf/util/evsel=2Ec
>> index dbfeceb2546c=2E=2E746e642d4d32 100644
>> --- a/tools/perf/util/evsel=2Ec
>> +++ b/tools/perf/util/evsel=2Ec
>> @@ -2221,6 +2221,51 @@ void __weak arch_perf_parse_sample_weight(struct=
 perf_sample *data,
>>  	data->weight =3D *array;
>>  }
>> =20
>> +u64 evsel__bitfield_swap_branch_flags(u64 value)
>> +{
>> +	u64 new_val =3D 0;
>> +
>> +	/*
>> +	 * branch_flags
>> +	 * union {
>> +	 * 	u64 values;
>> +	 * 	struct {
>> +	 * 		mispred:1	//target mispredicted
>> +	 * 		predicted:1	//target predicted
>> +	 * 		in_tx:1		//in transaction
>> +	 * 		abort:1		//transaction abort
>> +	 * 		cycles:16	//cycle count to last branch
>> +	 * 		type:4		//branch type
>> +	 * 		reserved:40
>> +	 * 	}
>> +	 * }
>> +	 *
>> +	 * Avoid bswap64() the entire branch_flag=2Evalue,
>> +	 * as it has variable bit-field sizes=2E Instead the
>> +	 * macro takes the bit-field position/size,
>> +	 * swaps it based on the host endianness=2E
>> +	 */
>> +	if (bigendian()) {
>> +		new_val =3D bitfield_swap(value, 0, 1);
>> +		new_val |=3D bitfield_swap(value, 1, 1);
>> +		new_val |=3D bitfield_swap(value, 2, 1);
>> +		new_val |=3D bitfield_swap(value, 3, 1);
>> +		new_val |=3D bitfield_swap(value, 4, 16);
>> +		new_val |=3D bitfield_swap(value, 20, 4);
>> +		new_val |=3D bitfield_swap(value, 24, 40);
>> +	} else {
>> +		new_val =3D bitfield_swap(value, 63, 1);
>> +		new_val |=3D bitfield_swap(value, 62, 1);
>> +		new_val |=3D bitfield_swap(value, 61, 1);
>> +		new_val |=3D bitfield_swap(value, 60, 1);
>> +		new_val |=3D bitfield_swap(value, 44, 16);
>> +		new_val |=3D bitfield_swap(value, 40, 4);
>> +		new_val |=3D bitfield_swap(value, 0, 40);
>> +	}
>> +
>> +	return new_val;
>> +}
>> +
>>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>  			struct perf_sample *data)
>>  {
>> @@ -2408,6 +2453,8 @@ int evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>>  		const u64 max_branch_nr =3D UINT64_MAX /
>>  					  sizeof(struct branch_entry);
>> +		struct branch_entry *e;
>> +		unsigned int i;
>> =20
>>  		OVERFLOW_CHECK_u64(array);
>>  		data->branch_stack =3D (struct branch_stack *)array++;
>> @@ -2416,10 +2463,33 @@ int evsel__parse_sample(struct evsel *evsel, un=
ion perf_event *event,
>>  			return -EFAULT;
>> =20
>>  		sz =3D data->branch_stack->nr * sizeof(struct branch_entry);
>> -		if (evsel__has_branch_hw_idx(evsel))
>> +		if (evsel__has_branch_hw_idx(evsel)) {
>>  			sz +=3D sizeof(u64);
>> -		else
>> +			e =3D &data->branch_stack->entries[0];
>> +		} else {
>>  			data->no_hw_idx =3D true;
>> +			/*
>> +			 * if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied,
>> +			 * only nr and entries[] will be output by kernel=2E
>> +			 */
>> +			e =3D (struct branch_entry *)&data->branch_stack->hw_idx;
>> +		}
>> +
>> +		if (swapped) {
>> +			/*
>> +			 * struct branch_flag does not have endian
>> +			 * specific bit field definition=2E And bswap
>> +			 * will not resolve the issue, since these
>> +			 * are bit fields=2E
>> +			 *
>> +			 * evsel__bitfield_swap_branch_flags() uses a
>> +			 * bitfield_swap macro to swap the bit position
>> +			 * based on the host endians=2E
>> +			 */
>> +			for (i =3D 0; i < data->branch_stack->nr; i++, e++)
>> +				e->flags=2Evalue =3D evsel__bitfield_swap_branch_flags(e->flags=2E=
value);
>> +		}
>> +
>>  		OVERFLOW_CHECK(array, sz, max_size);
>>  		array =3D (void *)array + sz;
>>  	}
>> diff --git a/tools/perf/util/evsel=2Eh b/tools/perf/util/evsel=2Eh
>> index 1f7edfa8568a=2E=2E2e82cdbe2c08 100644
>> --- a/tools/perf/util/evsel=2Eh
>> +++ b/tools/perf/util/evsel=2Eh
>> @@ -482,4 +482,17 @@ struct evsel *evsel__leader(struct evsel *evsel);
>>  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>>  bool evsel__is_leader(struct evsel *evsel);
>>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>> +
>> +/*
>> + * Macro to swap the bit-field postition and size=2E
>> + * Used when,
>> + * - dont need to swap the entire u64 &&
>> + * - when u64 has variable bit-field sizes &&
>> + * - when presented in a host endian which is different
>> + *   than the source endian of the perf=2Edata file
>> + */
>> +#define bitfield_swap(src, pos, size)	\
>> +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size)=
 - 1)))
>> +
>> +u64 evsel__bitfield_swap_branch_flags(u64 value);
>>  #endif /* __PERF_EVSEL_H */
>> --=20
>> 2=2E31=2E1
>
