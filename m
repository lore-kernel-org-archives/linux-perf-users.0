Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D872C15A5
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789834750; cv=pass; b=ImjDSAb6SKktnt57QEsv3icolcw6f8LmpyduWKy3jJmTqm5ZdSYhFy9XSlmQeHv01We0W5/FY9nF8bg9U7M0FGya+UQGKHpPWXA73av8TWg9x44nbUPzf9flC//TuOb9bvZRNTTdwUm1kHU6ofSGkPln77D2vYwSW1fkGdIuAiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789834750; c=relaxed/simple;
	bh=BzrMUNDYPj80iybGRN5GMtONkf6AbcxkplnCnvbZ21k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMouAXWZED5dmz3fhHpogoqZGkBZnnTk/l5c/fTfSiHUdr01eAj3RkjJzK+DkfVi6lqYAB2zUxpKIGosSK12eziyH2IWxrdtHDnCHYeu0aQ4GpDlshwx2suimhRYdneZlpBfjRBukWvj7I9lhhbtBdPN8FYpdOfGsOZb7MdRBmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxZd4Nst; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxZd4Nst"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-530e8c6fb80so119621cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 09:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789834748; cv=none;
        d=google.com; s=arc-20260327;
        b=lTSd403bInIUPcOc3vvhXRjaNUbj7HcWsDJdKk8y3oVFRlpebghJUiLD2lhZUa7zLJ
         blcd/HbnqxHqzfKH/dPc9WgNJL3uPPVHNZrAFJ9gJdGH6ovCn0N9PRiAGLM9EQWCZ7b+
         POaCK7XY8QpFOXmlrEyAUlQk4aI87oeM4pTTCAw3KR1O/lHYbC8fJMLVG/Ik5F8R3O2V
         +HmghmhgdmYAfKA+7aReD7H8qD/6q2wli2B04D3Wf6wubbV+LckOcKoL6evAVghu8CMc
         M3vNY7ARveiW+f2g7ifzFJwHzvWZ3JS7/VUpJ6UXpZ/5/s32f72W5xqmTpvOU29WCb3v
         Aicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xh+7X6sXCfesaHvraYzlE9MQtsqcfmtlPZC6XvJ+WDI=;
        fh=SRBKC0Abrc0b2nqf95kiBM3uCwKY468CL9C2hrGt3Kg=;
        b=M3tegyfj+nTmgYQjGYDyawk5DPKL/IBiPRAFEBMOcsiwV7IU3MrpYYYZMRELgEPS1i
         VbukcbrChpRmqE/v+1VGwniuuSMm5FHyEjVWmeUYzW2NLRr8VfUlcy0aB6yhwH7pRii/
         aHvL0Jf3GCtrymQOfYdTZsupsEg81J9If1mDfragF12PfsRwzx38yVtY+DFngzsbiEDN
         sXh/Kxz8j3mJCWMeWhEKGiRF/wFixogP5/xlkXEG3eupHaXFVHJUqjs7kIgKnBkYCcws
         2tFfQWHWrikjBFSZXl3+PcMGh/2lG7NgZ6slMQ7w3WlsZS3kHyFeFgYWD0nqwIUh+0fm
         egxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789834748; x=1790439548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xh+7X6sXCfesaHvraYzlE9MQtsqcfmtlPZC6XvJ+WDI=;
        b=AxZd4NstcPkWbrgDqK/s5WDnS9KuFMb/3ZiYxPcRiR73NyLh71nJf2bT41lRiAbUql
         JabZ4LqOOye2NNo/1QND2w2kgB0GBjEqQ/jXc68Mv1l64WKlSfG6tzHjeVLvAk6MMKWN
         4ACmVKuL/KZwIhyFsb5Y1GCTZBqNQ/Z5+uhxw1fftsbaHXP6hbi+5sPD/8sCK5Jnaaat
         PsZmcBvz6lSXiJ3Mh2Jjwf3W1qpX8CSnNpJFZ23QUPWegDNsBDGW8b6tEKY3mRdeOJy8
         ETE9pJOCykhN2zEe4PFQtey69IxGF8zu1zii8LdCAELDWHtRyHMJtjuTM+Zzstc1/mQ/
         aj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789834748; x=1790439548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xh+7X6sXCfesaHvraYzlE9MQtsqcfmtlPZC6XvJ+WDI=;
        b=lgNgI+yG/lKigjWN2wt8+u4JyJY+0wvZdRrFjerCl7yXJBT2zBpSFIrATqEyJngDhr
         //cILV1N8RxMyOOVqFsbqzvPuPwS2gJq0Uxk1UJKPfAaPzCixrk6ShKTHv41jcTYY4Fu
         Bhm8Tf7pJTbAQdSqsmUDz6ZQuaUtjrf0rkuQDNTUeGQjIq2UvWHQG7kZOVZ0hLDxNvvf
         s/zCbJyTX3+4Ygg7bQZPE3G76Bd5N8RNvjfbhe+uFnV+srgsqv7kvYE1gmTvBbxX7hFC
         Xk9Q74k1HIbEdkXVM/x1dstnBoCy4jgHaHD7qUA0UCb6YkNpDKmSu8G2nzfn3T2xrkN/
         MzbA==
X-Forwarded-Encrypted: i=1; AKwUvByFQfgaO4b1DxgivTy74QZrLhND9TNwODbm6pCHM8zMwOTwGEr6t93VQE8t5qcsgi7+uSYF2k1ghtJwmKmRUrWk@vger.kernel.org
X-Gm-Message-State: AFuF++mGOhMvep8uW4m/3S8KhA2qLqF/kGuq9Bg24uvdWK/sNPvmpV7e
	beNvB23DCGqTw3jZYxPJ29/srM+jCQ1b0ktA3L9pEL2eGPy2hu99fj6BWLeqJAGdeRPpLGm5HP2
	NGYJ/lAidUyEBaZOvZWL+kjpkz+fx3UOULbJg7Ev0
X-Gm-Gg: AYBFou3ZOEMsCa9WYi/TMo7NoLAGSn+zAyCZXLIPKm96rDFmQPYe2748q+cehOoCNQQ
	NezQ1qBoDJjZda1/nMI9zVZ/UdhdTVvZ/RuXUbAf2kOtwDBYUHKtLCSPIzOq0sRwO/RN6PignlN
	Mlvwgg2aRF/a6g9WTA4BWfWI/9NemQIJLsI6XABcsdEHW5LzdXO2IZRnvnjPtR3iqoX09Ih7je2
	/cQDYBJruIbxLksr5lAM0C9OOZewSD9NL2dDEBMg2p8Hbq6PTtASfJGfR3KUI9jD69t4qN4SIXx
	oSdBTjGTk/j5TOvlHoxw7XXs82gVsV3uBsvaFirS5BEdY6XKxSfE21U=
X-Received: by 2002:a05:622a:2c6:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-532b74745c2mr4345361cf.14.1789834747062; Sat, 19 Sep 2026
 09:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919063745.48444-1-namhyung@kernel.org>
In-Reply-To: <20260919063745.48444-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 19 Sep 2026 09:18:55 -0700
X-Gm-Features: AcwNN1WQC-Rm6OzY1guSOIIS0q-0qgLy5a5dVXEVUsRU9fEFsTJ71sWSPbEY2nU
Message-ID: <CAP-5=fUt43_08GcNV3bz-SFmRjBN+NoNZ7zEJyBDa+tZiN0vdA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] perf annotate-data: Support flexible array types
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Zecheng Li <zli94@ncsu.edu>, Yanbo Zhao <yzhao62@ncsu.edu>, Tengda Wu <wutengda@huaweicloud.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 11:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> The flexible arrays are dynamically allocated with different size.  So ch=
ecking
> with the original type size won't match and cannot find the type if the o=
ffset
> is bigger than the size.  This patch series detects those flex-arrays and=
 allows
> accesses beyong the original size.
>
> I'm not sure what's the best way to add test codes for data type profilin=
g as it
> seems we need to add a lot more workloads for different cases.  Probably =
we may
> want to split the workloads as separate binaries.

We have tools/perf/tests/shell/data_type_profiling.sh, I wonder can we
not just have some workload with a:
```
struct flex_array {
   int len;
   int vals[];
};
```
then create a randomly sized flex array and access  it in a loop something =
like:
```
struct flex_array *a =3D calloc(sizeof(*a) + random_number * sizeof(int));
a->len =3D random_number;
while (!done) { /* done is set by an alarm like with noploop */
   for (int i =3D 0; i < a->len; i++) {
       a[i]++; /* Expect blame on struct flex_array here */
   }
}
```
ensuring the type profile blames the struct flex_array?

Thanks,
Ian

> v5 changes)
>
>  * add a cleanup patch
>  * add is_union and is_flex_array fields to find member correctly
>
> v4: https://lore.kernel.org/r/20260916061926.2224222-1-namhyung@kernel.or=
g/
>
>  * update last member even if the offset is same
>  * handle type qualifiers in die_has_flex_array()
>  * add zero-length array members as flexible arrays
>  * check return value of strbuf_init() for type name
>
> v3: https://lore.kernel.org/r/20260915064035.1970175-1-namhyung@kernel.or=
g
>
>  * patch 1 was merged!
>  * check if last member is found
>  * check member location when finding flex-array
>  * ensure member typename is initiailized
>  * fix a bug to pass a wrong type in check_variable()
>  * fix a typo in a comment
>
> v2: https://lore.kernel.org/r/20260914064535.1671939-1-namhyung@kernel.or=
g
>
>  * fix missing index increment in the histogram
>  * support flex array in union types
>  * add recursion check in die_has_flex_array()
>  * check negative index arrays properly
>  * avoid divide-by-zero when the size is unknown
>
> v1: https://lore.kernel.org/r/20260912054706.1475583-1-namhyung@kernel.or=
g
>
> Thanks,
> Namhyung
>
>
> Cc: Zecheng Li <zli94@ncsu.edu>
> Cc: Yanbo Zhao <yzhao62@ncsu.edu>
> Cc: Tengda Wu <wutengda@huaweicloud.com>
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
>
> Namhyung Kim (4):
>   perf dwarf-aux: Add die_has_flex_array() helper
>   perf annotate-data: A small cleanup in __add_member_cb()
>   perf annotate-data: Allow out-of-size access for flex-array types
>   perf annotate-data: Adjust type offset for flex-array
>
>  tools/perf/util/annotate-data.c | 192 ++++++++++++++++++++++++--------
>  tools/perf/util/annotate-data.h |   6 +
>  tools/perf/util/dwarf-aux.c     | 107 ++++++++++++++++++
>  tools/perf/util/dwarf-aux.h     |   3 +
>  4 files changed, 262 insertions(+), 46 deletions(-)
>
> --
> 2.55.0
>
