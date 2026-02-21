Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788501A9F90
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Feb 2026 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771661201; cv=none; b=jrdRF26p5ZalDwEYsSRrqwuWXp2UdKl7gnat5eT3LsYDybw+/78P4npm+gW+9hBIovtIUgIPO6EJCw/WVR6Vjpb7ATTuxIj1cP6q2iM200TpK/+5vN74SClBclropfmFX/Xyypd+q2KbewAOoAzxgQIdy+UfugrJfwHU5APX5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771661201; c=relaxed/simple;
	bh=zTwDmuvPa0SUurZNjeZqKUecFTx+Zt1nGFMLtVrnpE0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iE++Jkm6HPRmEsY1AIF2ebi5YCJ6FRampPm6P5FKAN6THfNkkiJIvJITJxOpFiZ5iOFb0NJmDR+GtNKg9Y4f5NBIULEnNE/QfzUoE2N3zTmlthseijfJiR5xxupsxK6LQKkpAUoG7UAjlZcQ5Rrw3aRfaxlezwthQ/FiyrWS4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHbKBjaG; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHbKBjaG"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5674d8be45eso1071757e0c.1
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Feb 2026 00:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771661198; x=1772265998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MyizYJxv4cBrjVconLgaLYuqU8PbC7PShpJR5rKWyxo=;
        b=kHbKBjaGJ1ipu1Jkxf04k/IEuGC85B45jEUDAhnP4sfbPcJAxFQGv/mPqB1xaKgeYd
         keq0DB5O8l3b2QTM1P5dJab4m+KPLG5PZzehjWq2FhvSW5fCFLTLY0zDSFd2zRq0kPLh
         81hVMt2peGX52x2WJvCfhTQr8x9AW8NhahDG7ZnZ0s0Z1Obu5YqLB9SqheuST2mst9mb
         rzlvyXrrPVAxc4urm8XuMt25OzUw1B62WsfnZbBRfRhVbUd5DFQVtDOZv11ul7FsQgYc
         jyEzyOA++U94nhK7fB53dDFPOTjEI2C0J0kYve3aCCF5MQPD2ed32WF366gKt4gS/Uc+
         URaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771661198; x=1772265998;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyizYJxv4cBrjVconLgaLYuqU8PbC7PShpJR5rKWyxo=;
        b=CqwdjGDlbWR75MY87YeAD5KnGssBJxsbxHjGFK/KmjW4192+ZQ2A6uliBx0Kki+AQN
         vR0663kZv7fRLESyNw/nQ9upRfKBftX4poL/c+vCqxMdZiccZ9ngWskJ4AFZaMlMUVoz
         tNHGqdWpUaGsPsz5Qap7zwFo5BWltwLXIEf51wtnB//rjIXpFBWibOt5Z2TnXYFyMijO
         2NcOlM0M2GocABqQr2KV4qczPM9+6eqiqnwdUeSj7NLgw8eYZDgqKaB5R54jqLMCEDy9
         SyfvdEmaQppTJz47VbvFUDhAPkVE9Ftg39oJTPRMLMcQUTVllxv2+NabimbZ7+91N96b
         9ZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKU33QcfDk5zzWQZ0e8G3ESZMpsTRPVqpM6aBa8Qcbh929ZJTFHQqLth8dBbPfiMORakKlI16Gvdmzx4gaHTQP@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEumX82s4XqZaqEKw5EbgQnffd6X3sjeUyKyNFwbYosgzUsop
	L5hfSty9GEoT/V0GjJ0O1TKl5x+OC9SXB0okO7R00LIicKVD/jpGVaCr
X-Gm-Gg: AZuq6aLzzrXlJeoykC7SeCgcsatoKJC5QCHZCMoX0vB7U38ZWZYKcUMTwDFRQJ3Ywp9
	/JQzp7RJraTJXAgQaeWyp8vaUkuLDAmxyJ3oSBWYu16IZ5V3g99+IRfoL7CQTdY8O+ciAriKZL4
	9bOHymq5jVtgS8a4KjsFa8fwbHAh4Agx7Cvn6iVEXiFx9VxUoDi3qgzAwZu6ezug0HgZvTazmyp
	tjtAf94qx7RQKXhol1zlfZIuM3bDn7pCaixUejR9pVO03m/Fe4iz1iPEfXEQ2gSxE6B7E0R1fVw
	+6sKa2IXVGxzCAK6YJULXODoUdB2t6sqSLLY5hTHzcdewTPsSiDVz+hBbkPgrPODorTGiElcFbi
	GMwVtn0NuavstUXfSQXavXwWBiybO1/4nOiFfpljuVOTaMefPXlvye0SShC46HiA696JnULKzSC
	sJDY4ZaFbbK6yr0XFmEVKQBsvWWPtA2/r/32oN
X-Received: by 2002:a05:6122:2a55:b0:55b:d85:507a with SMTP id 71dfb90a1353d-568e47ab129mr918427e0c.7.1771661198162;
        Sat, 21 Feb 2026 00:06:38 -0800 (PST)
Received: from ehlo.thunderbird.net ([186.208.68.154])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e579bbd9sm1916290e0c.1.2026.02.21.00.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 00:06:37 -0800 (PST)
Date: Sat, 21 Feb 2026 05:06:02 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>
CC: James Clark <james.clark@linaro.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_PING_=5BPATCH_v4_linux-ne?=
 =?US-ASCII?Q?xt=5D_perf_parse-events=3A_Fix_?=
 =?US-ASCII?Q?big-endian_=27overwrite=27_by_writing_correct_union_member?=
User-Agent: Thunderbird for Android
In-Reply-To: <aZjz47hv-_sVNya2@google.com>
References: <20260217131456.4085419-1-tmricht@linux.ibm.com> <9a16463e-c2d9-4ab9-bd1a-a9c6e7981412@linaro.org> <53e9060e-cd7d-49eb-a100-7f658fa0f17b@linux.ibm.com> <aZjz47hv-_sVNya2@google.com>
Message-ID: <42EA4B19-C0F0-459A-B9E2-590A09CC35F2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 20, 2026 8:53:07 PM GMT-03:00, Namhyung Kim <namhyung@kernel=
=2Eorg> wrote:
>Hello,
>
>On Fri, Feb 20, 2026 at 10:31:17AM +0100, Thomas Richter wrote:
>> On 2/17/26 15:09, James Clark wrote:
>> >=20
>> >=20
>> > On 17/02/2026 1:14 pm, Thomas Richter wrote:
>> >> v1 -> v2: Add comments from James Clark and Ian Rogers
>> >> v2 -> v3: Improve switch statement in add_config_term()
>> >> v3 -> v4: Fix clang warnings
>> >>
>> >> The "Read backward ring buffer" test crashes on big-endian (e=2Eg=2E=
 s390x)
>> >> due to a NULL dereference when the backward mmap path isn't enabled=
=2E
>> >>
>> >> Reproducer:
>> >> =C2=A0=C2=A0 # =2E/perf test -F 'Read backward ring buffer'
>> >> =C2=A0=C2=A0 Segmentation fault (core dumped)
>> >> =C2=A0=C2=A0 # uname -m
>> >> =C2=A0=C2=A0 s390x
>> >> =C2=A0=C2=A0 #
>> >>
>> >> Root cause:
>> >> get_config_terms() stores into evsel_config_term::val=2Eval (u64) wh=
ile later
>> >> code reads boolean fields such as evsel_config_term::val=2Eoverwrite=
=2E
>> >> On big-endian the 1-byte boolean is left-aligned, so writing
>> >> evsel_config_term::val=2Eval =3D 1 is read back as
>> >> evsel_config_term::val=2Eoverwrite =3D 0,
>> >> leaving backward mmap disabled and a NULL map being used=2E
>> >>
>> >> Store values in the union member that matches the term type, e=2Eg=
=2E:
>> >> =C2=A0=C2=A0 /* for OVERWRITE */
>> >> =C2=A0=C2=A0 new_term->val=2Eoverwrite =3D 1;=C2=A0 /* not new_term-=
>val=2Eval =3D 1 */
>> >> to fix this=2E Improve add_config_term() and add two more parameters=
 for
>> >> string and value=2E Function add_config_term() now creates a complet=
e node
>> >> element of type evsel_config_term and handles all evsel_config_term:=
:val
>> >> union members=2E
>> >>
>> >> Impact:
>> >> Enables backward mmap on big-endian and prevents the crash=2E
>> >> No change on little-endian=2E
>> >>
>> >> Output after:
>> >> =C2=A0 # =2E/perf test -Fv 44
>> >> =C2=A0 --- start ---
>> >> =C2=A0 Using CPUID IBM,9175,705,ME1,3=2E8,002f
>> >> =C2=A0 mmap size 1052672B
>> >> =C2=A0 mmap size 8192B
>> >> =C2=A0 ---- end ----
>> >> =C2=A0 44: Read backward ring buffer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Ok
>> >> =C2=A0 #
>> >>
>> >> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms()=
 to remove macros")
>> >> Signed-off-by: Thomas Richter <tmricht@linux=2Eibm=2Ecom>
>> >> Reviewed-by: Jan Polensky <japo@linux=2Eibm=2Ecom>
>> >> Cc: James Clark <james=2Eclark@linaro=2Eorg>
>> >> Cc: Ian Rogers <irogers@google=2Ecom>
>> >> ---
>> >> =C2=A0 tools/perf/util/parse-events=2Ec | 82 +++++++++++++++++++++++=
++++-------
>> >> =C2=A0 1 file changed, 65 insertions(+), 17 deletions(-)
>> >>
>> >> diff --git a/tools/perf/util/parse-events=2Ec b/tools/perf/util/pars=
e-events=2Ec
>> >> index b9efb296bba5=2E=2E7b4629625b1e 100644
>> >> --- a/tools/perf/util/parse-events=2Ec
>> >> +++ b/tools/perf/util/parse-events=2Ec
>> >> @@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr =
*attr,
>> >> =C2=A0 =C2=A0 static struct evsel_config_term *add_config_term(enum =
evsel_term_type type,
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct list_head *head_terms,
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bool weak)
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bool weak, char *str, u64 val)
>> >> =C2=A0 {
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct evsel_config_term *t;
>> >> =C2=A0 @@ -1128,8 +1128,62 @@ static struct evsel_config_term *add_c=
onfig_term(enum evsel_term_type type,
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&t->list);
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->type =3D type;
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->weak=C2=A0=C2=A0=C2=A0 =3D weak;
>> >> +
>> >> +=C2=A0=C2=A0=C2=A0 switch (type) {
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_PERIOD:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_FREQ:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_STACK_USER:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Eval =3D val;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_TIME:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Etime =3D val;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_INHERIT:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Einherit =3D val=
;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_OVERWRITE:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Eoverwrite =3D v=
al;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_MAX_STACK:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Emax_stack =3D v=
al;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_MAX_EVENTS:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Emax_events =3D =
val;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_PERCORE:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Epercore =3D val=
;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_AUX_OUTPUT:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Eaux_output =3D =
val;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Eaux_sample_size=
 =3D val;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_CALLGRAPH:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_BRANCH:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_DRV_CFG:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
>> >> +=C2=A0=C2=A0=C2=A0 case EVSEL__CONFIG_TERM_AUX_ACTION:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (str) {
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
t->val=2Estr =3D strdup(str);
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!t->val=2Estr) {
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zfree(&t);
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
t->free_str =3D true;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 default:
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->val=2Eval =3D val;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> >> +=C2=A0=C2=A0=C2=A0 }
>> >> +
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&t->list, head_terms);
>> >> -
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return t;
>> >> =C2=A0 }
>> >> =C2=A0 @@ -1142,7 +1196,7 @@ static int get_config_terms(const struc=
t parse_events_terms *head_config,
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct evsel_=
config_term *new_term;
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum evsel_te=
rm_type new_type;
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool str_type=
 =3D false;
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 val;
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 val =3D 0;
>> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch=
 (term->type_term) {
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PARSE_EV=
ENTS__TERM_TYPE_SAMPLE_PERIOD:
>> >> @@ -1234,20 +1288,15 @@ static int get_config_terms(const struct par=
se_events_terms *head_config,
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_term =3D add_=
config_term(new_type, head_terms, term->weak);
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note: Members ev=
sel_config_term::val and
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * parse_events_ter=
m::val are unions and endianness needs
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to be taken into=
 account when changing such union members=2E
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_term =3D add_config_=
term(new_type, head_terms, term->weak,
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str_type=
 ? term->val=2Estr : NULL, val);
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!new_term=
)
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENOMEM;
>> >> -
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (str_type) {
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
new_term->val=2Estr =3D strdup(term->val=2Estr);
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!new_term->val=2Estr) {
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zfree(&new_term);
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
new_term->free_str =3D true;
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
new_term->val=2Eval =3D val;
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> >> =C2=A0 }
>> >> @@ -1277,10 +1326,9 @@ static int add_cfg_chg(const struct perf_pmu =
*pmu,
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bits) {
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct evsel_=
config_term *new_term;
>> >> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_term =3D add_=
config_term(new_term_type, head_terms, false);
>> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_term =3D add_config_=
term(new_term_type, head_terms, false, NULL, bits);
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!new_term=
)
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENOMEM;
>> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_term->val=2Ecfg_chg =
=3D bits;
>> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> >=20
>> > Reviewed-by: James Clark <james=2Eclark@linaro=2Eorg>
>> >=20
>>=20
>> Friendly ping, this still fails in linux-next=2E=2E=2E
>
>Sorry for the delay, I'll queue it up after the merge window=2E
>

Thanks for the ping, I'll consider it later today, when I plan to send the=
 pull request for this merge window=2E=20

- Arnaldo

>Thanks,
>Namhyung
>

- Arnaldo 
