Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2341440B
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798310; cv=pass; b=L+d//LKNBwisdHqk2Lw16ULqu962H3W9/LDk0JqXAFGUh4id/j1UCM7leQXlL6qvRFeSYhNCl/2EN80scucPplTsraCwqvl5WSpApSfzd+WErPtQXaLqLVSyeD581dz3/O+4YzydtqYLO+cwtrwAicGzo0fmyuGgXgPYG1DWOGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798310; c=relaxed/simple;
	bh=IYWiKJkDCp5x3ARAQGdZNJcgTTfydtt28kmbsykDHMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRkxuH7wigIclmJlfbECrbJMRi1OfWd08XFsaNM3hQ4PMCQB094bkYphtUHg3XZ+L2gflcNkzz8/7jBYNWR5GA6EP0LblUol7YbLNvbs7NWT/D5FHKm3aAoLdOmdxHVSfH6VyzjAllVn0SAvknvDfqTOGvhSPn+zBEQrcwqsvIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=JF9PTfE5; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="JF9PTfE5"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f516c271so5243911d50.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 12:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790798308; cv=none;
        d=google.com; s=arc-20260327;
        b=GSZewWztfUOoiQYygPrE+Cn9KiylXSuJ7sivRJ7xJ9qp6cBbFPMwcOIDDm0V5Bi43N
         JZNkiWGuD5jwViYwWzmbd5dHbGAqUdXk1p0lmE516jXKWAoiLQN0JKGZoYH5nHtOZExP
         0CXGyPbS6IBXctK/JItSDW8/yzXyvtnXvJnTYCd76wooIHs2CgwflkcmhSKwWVi+FDX6
         ud/Xo9OL75rSvYbBtqU/Q/5GuneAaNcbu/tn75VcyzXjAyBhcbYxI/sHfKpTPE1m3vYt
         ArirDKSSCL5Yjv2PH/WUj2KqfHXbeFEqga2kv3sJAlYbY32LyLyWJ6SZ7CmZHSgfQkSY
         0oLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IYWiKJkDCp5x3ARAQGdZNJcgTTfydtt28kmbsykDHMk=;
        fh=crctLzzuJ3Vka9/M7aT/1jgqXs2DpcD4ihoCHjqqYDw=;
        b=h4LdCBPFFal4XKwOhFCDCc9J3W6Z6pdmJLLuXzXucisNn66i+PhSUPJtYnk5j0Lc9v
         QfNVhEzkbrm2s9dnSY8rJSskhO7tLuli1KZSJbeXEc54h4MqHe0Eusi6JhCfJab87raa
         FPsMtiCH4zvVFTW1TWAyQwymwKImTb3ljwdHGIoD2rE/RTJy8Y3W1fcrL37POFlNDb/y
         5eSOz0LQEbbvKP5//JMmvE7FEwsYCBwjFOwa+RNMx8fFTS4KTleJBB+QAjPwiq07gy/q
         duthMwv+yO3Z15CCpI+jykB64i1DcEYvH/VxlaQSEIl6UxfLVSp/eVwYNC310kiwx6qS
         f00Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1790798308; x=1791403108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYWiKJkDCp5x3ARAQGdZNJcgTTfydtt28kmbsykDHMk=;
        b=JF9PTfE5fRuc/2lBIe3zThtPWeWV5KaH+CYo9nEaaZESjnxqWwLFwfCNCkFdLZ/waO
         7ayuh96QFv070tV6HGcUurElPdVbVdy6G5aKz9y99AE3xAkBxJbmqg+u0slOocFYSnzL
         OfRkVo6Y0S7LOAeauEXgi1QTLA2pMW3bUGX9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798308; x=1791403108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYWiKJkDCp5x3ARAQGdZNJcgTTfydtt28kmbsykDHMk=;
        b=WVJtVkAbCdLvfkIziV3KzBqb6siCsTLYSd+wGDLYLFWkuuT7dXogrZ8zQcuPqLplmj
         +QVLEpyJu8x/tCTXtkb6APkGag99TVydutTiOSWst//6LuwWa9n8Zy9/A+Q6jvOITx/3
         9X2yXPLAxwhfYAool5thyDipCV0njkgWcYD6OmhrWFbY44H5vonoiv87wTXh90NIehar
         mZMf1BF4dWdebDQTVJz4wfQh7ATKm4k2Z/JHzyYyTVHE6ZxdEP2Bc7hjOucOkPRouLQT
         Bm+jOzlqjSancocR6+vqiciRZ7O31/wdT4CekhvZJY21YvK76vSvbatpwM/yp0y6kvlq
         riTg==
X-Forwarded-Encrypted: i=1; AKwUvBwvZhy3S62duhb1QKcLN42zkdVziiujOM6K5AJ7zDi6nJJ9m9HkUMIcHipbR6/lRQlRoUMGaAOTBPFrOpSb/Wml@vger.kernel.org
X-Gm-Message-State: AFq9FYI8P0sLID6esrk7nn1SHxgVJBTEY4ouIYwBubOpkejL8E/ETlBW
	jmPvJBUkPZ5BJfp6d7tJgYR5GnAipWWAOIeKvQeOerT0UUz2CK2GkP05/yL+JnZgYrmLPE1KnsR
	x9+UKReYYMnLPIP5QLFEgngFx0m6jvlu5sGVcFQj3Cw==
X-Gm-Gg: AYBFou3pfho7P8goDxFEO+IaN1JXlUHC82Xorfi1+eIqYYU8G900ZmlIMqi21gaLdte
	exO6Yl0QbXLQsi5U+GHG9Bq5GtbJiYgZnCDJcOIRGBxMaE4WLyXR+rdfukNpYlwDLFueNuIJnBB
	4+pEJbRlBNZ6QcHJV3ZpKLeJdiP1SZcgmgp1KfRVN9Y2TzPONKZj6s3hn+4j2PGn9Cp2MzL5FN0
	NOV+I+mo0RDBk3Ln/FL+vcs0pVak+Ypqkd2Mqkm/NY/NbBkIxCphF+GF8J9Kfk9z+1QySQ4NAQp
	EYT5+S8DXFc0TU+CKfkGwrWScUfdb3/DD3s2nLJSpTmexXyAr7JJSLmdHP0ajT13z/XDV7jrH12
	g9W9anYw4iNE=
X-Received: by 2002:a05:690e:d5b:b0:674:2041:89e with SMTP id
 956f58d0204a3-676834672fdmr1239550d50.42.1790798307260; Wed, 30 Sep 2026
 12:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <CAP-5=fWLp5c9HYZ6oTsfPhWprz3uMTT=mt3M-OVu8GEjzSpEww@mail.gmail.com>
 <CA+w=M=Tdyt=s9FTvDH_4ozk_1MM09J6xTdLrsq-WNhQ1S+ACXQ@mail.gmail.com> <CAP-5=fWMF=HrQwBObz1ryc7e+=0iJAwT=QSa0neYT73xCfqAjg@mail.gmail.com>
In-Reply-To: <CAP-5=fWMF=HrQwBObz1ryc7e+=0iJAwT=QSa0neYT73xCfqAjg@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Wed, 30 Sep 2026 12:58:10 -0700
X-Gm-Features: AclHuK_SPtTsJugnN6QRlQJvW6Bus54R8VrCRQSl71DQf_wzl1pLk8I7Dle5dp4
Message-ID: <CA+w=M=TP=uMcYd2SEG0NvZ=2uLNKD8kekAEVsrBjPKGTTn_9XA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] perf script: Bounded and lazy symbol loading
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:56=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> So, I'm pretty against the complexity of dealing with symbols that may
> fail due to a memory pressure issue.


Hi Ian,

That was aimed at --max-symbol-bytes. I'll drop it in v4.

Following the other thread [1], it looks like we agree that lazy loading is
worth having on its own. Whether or not the reference-counting series
lands, loading a name only when a sample needs it is a good change. As
in the numbers I posted there, it cuts memory use substantially and
makes perf script faster. I'll prepare v4 of this series without the
cap:

1. the ELF_C_READ_MMAP fix
2. reading DSO data from the debug file the symbol table came from
3. the shared duplicate-symbol selection
4. --lazy-load-symbols
5. the lazy-loading tests

Patches 2 and 3 stay because lazy loading needs them, and Namhyung
asked for them.

Namhyung, on that thread you suggested a limit that prints an offset
when the name is not loaded. I said I could do that for the byte cap
in v4. I'd rather land lazy loading first and add that limit later if
there is a need or interest.

[1] https://lore.kernel.org/all/20260928075237.3055101-1-irogers@google.com=
/

Thanks,
Alireza
