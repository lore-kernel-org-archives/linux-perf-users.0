Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B810A1E;
	Wed,  2 Apr 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743556632; cv=none; b=UucDMTDrDHW0HPOGXC9a6M6iEQ/eX/eUDUQYRxrnwi1y+LFgMfqqFIJqfOUv03Z4kls3JHtmoLv4vWDKJhE3buMLFrSqFKN6kNaAa7KW2h09TWsdr4GzzXwDKmIwy2qsM17cfBH1CgpgfFE02qnTWi6lEIsa9nIJ2RTtUs1cYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743556632; c=relaxed/simple;
	bh=swipl5oxE4ODEOIlrmHfcaSGqYf7QFc1E+yw39UEO5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqvgdkjX3/REykpPjCTDHMdbH/0bvJSfHnD7u1lyjxwBtKWQgnVsnJexfcI4T5llbhHQoi2OBUeVe8iH0Z9BEzO6oBzBpStzMMPm6sY4h5u7bfgdQ05MJUi0eyv73n8Em998bahh2CcCundAEQBBKoDQCQGqE4RDUw9FcTB1gR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6ZFr4Dy; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6ZFr4Dy"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e6df4507690so184245276.0;
        Tue, 01 Apr 2025 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743556628; x=1744161428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swipl5oxE4ODEOIlrmHfcaSGqYf7QFc1E+yw39UEO5M=;
        b=E6ZFr4Dy4COhYgcavOpQKMhOFiUc/+VRLktfpK08+l35vl8BLsqrXEqTNIMUM8Eos2
         hGzpXcQr44ZqMPNd27NRSdgRSjMlLQKvX1IMWrxWajNC+6lbULr23XmOO8+4DRh2kRy/
         bIOJ6jK/z3L5gP3lndH7pUGzAWNFuVRjZYlf5h+dN6ODnSluUdMVYAkdq2i7CD38sugm
         Ce8QRJvsmBRsB6yWt2dAIJxJAVPoTvcfrsb2BhPaSLlE2doTsBqzNVs/dgM2TVIIX9DI
         XUgxG0fnaQaAwxZnpkaPCVErMewHx+B2G9IJIdYIkcfybVVkB1IqxF51MOuZB+WKgBZx
         jw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743556628; x=1744161428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swipl5oxE4ODEOIlrmHfcaSGqYf7QFc1E+yw39UEO5M=;
        b=C5tncW7a/FBKRjyhPPVrWwZ8+8/F6VtHYCbRWa5hGQenTjf9ZKYwJogDvEtR8Mjdwd
         JkxwFwQnoOuEFfyp6AjBTLSD4qvNqcmlkw6PqYx9dKBgOOroOfc55xpbnvbfxJ5RE3lN
         1l5Ntcg8b2xP2Ak9orrfrCIPDAanO0Xx+dyuWibbsHBO0TJi/0EzKJ2RbpA777Z3dG7i
         393+Pv8ggv6dbDJpza4+pM9fUBuyD5+q5d1Muo9AuuHWa1dKWOsCWI5MMhP9dr0Xp93y
         5cXNuELkPpHahVyfY7MOgyPZH6OFDEQEzFqxCOtgfZhU1tyV3lj26vCSQqRd6Tpg0zGn
         jZHA==
X-Forwarded-Encrypted: i=1; AJvYcCUikdyv0ErbWYotjRhiZzoF8qLGh6/icC51WLdAVfyP3PoTDExHaAugpQn9RacFAH9k2+WZfOx7l2CsJi0VpZnyqg==@vger.kernel.org, AJvYcCVZo53lzMxR9PkK7rWcLWxBbvN2Zr1GoOxylmRPGjq/jj42ZVNi4sLXoz23vurKRsV954QoimtKNfJy7eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtEx2KOknxjiwADrTmDv7C1FzR8HDjcRvRuXvJV/yATm52ZHy
	b9/A2VynVl2oK2akW6ddIk0gb2LQqpmQbVxYZJKscVmcqXz4Fpj7o8nfpxByZVPkHDnCkO7i3vd
	2I+mzoVnwEtDCsPspYQDj72C3P4s=
X-Gm-Gg: ASbGncvocP+l52yhsadsXACHDNpTl3EewSrp7a1UBAWpMh0nIGbXdahPeceTb7rFAPf
	icv8x3TIN6ED3BpDjUldwC2VUVvKCI1Q5h/n5grJhWoyrdZCngCa7xrWC+Cn0tKGY6MEZ5fDFcN
	uc1BVI6Tbk038SKyozUp8IyOZi
X-Google-Smtp-Source: AGHT+IG/91ENxbepjMyxtVQqTL6BDvXW5rqrjR2a9fCTAq97ARvcFIwCflHMx5r0fT1XfCqD6gLbcT7ErRutUlwnAhc=
X-Received: by 2002:a05:6902:2e09:b0:e5d:c1b9:4a7 with SMTP id
 3f1490d57ef6-e6df77d72c0mr385260276.23.1743556628355; Tue, 01 Apr 2025
 18:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401202715.3493567-1-irogers@google.com>
In-Reply-To: <20250401202715.3493567-1-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 1 Apr 2025 18:16:57 -0700
X-Gm-Features: AQ5f1JraaChHXxTubylT8V4ERwaiHvVI9vcdLb6sgZ45sMybzjbrEN0dV1VfQtM
Message-ID: <CAH0uvoiChpJS9Px0rQW0yRvHq7UjVauxH+5tRZ_Lt5V=yrAPiQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix some more memory leaks
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Tue, Apr 1, 2025 at 1:27=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The files.max is the maximum valid fd in the files array and so
> freeing the values needs to be inclusive of the max value.
>
> Add missing thread__put of the found parent thread in
> thread__e_machine.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
