Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2F1DDA09
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Sep 2025 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757745323; cv=none; b=G5ot3uav/Kwlbt0D1IteT0KJbG6sozZHfaPOlXqVn3p8V5v0oCVqVMVih2rktXhEhDGXYwWiUixi5hLADcfyPu5usBU1CTV2sQ+G8+fNSqgPpGCqJj9lmGvjOYqYd4k8l+9gJr/CPCGz1SpwbAUIWtf3I6u/vH3hDoV5GdPto84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757745323; c=relaxed/simple;
	bh=+MrZdmNVCG2OdQ4Nn0NGHXqto2cWIelVt/Phs7xDyRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UlTm8CNDsouWrA70PjgK8mkpd043IMkWp4Hrm+YLBqoJ08sXmHbtbxO4GCJil6HQfWVJSuN3/u4ow9qrUi0bAcdhJ30lGTLyNdAagrNPhtPKn6ie7Y8YVSqY/NV5Q4ossRukkiO5fN9X9e3oCSpmg2epD9UPDmpe/8aJz9c8ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5nDp3+G; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5nDp3+G"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b96f83238so218904a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757745321; x=1758350121; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMj3cfgRXbo5TbTq5fxmrLscUg24nKM3Od2dH2JQ1YI=;
        b=l5nDp3+Gx58LH6nYilj7/sSnHRarvFYfgpAkBu6QNVhta6Q2QX1zxICxnseZIOOj1L
         fM1UBt9Iu56N6TqSL+ZBj6s/1mTpmb51TCZi0rmH143IzVSR+A5/CLgBPW20lKuuDyFl
         gVd4O+b7mI/XsgbAIwsP84rMvfIgTfA4hVKuJWDhgWkYix2MqvxuGXkVgj+SPu0Qk+fe
         40r7M1MKWOtyKzr52TYA49ZhnGF+kPK0TL7CjruaSzyICdeQYQKLCIEWNrFerHc5H3tM
         v5KKkEDp3sI9ObSBty51kRiWJeAtI3Dvzq/vr8Zkb0G7scyTN5EsLRoVnHhjUoGTZ2dQ
         PYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757745321; x=1758350121;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMj3cfgRXbo5TbTq5fxmrLscUg24nKM3Od2dH2JQ1YI=;
        b=toqicdUgFZmhQexT8IlPPBh2ymWL3arzl7FhknEM9G8oc0WW9J158E3kbnbMiH2xDx
         loXMXffnaYFGCdh/iqau3L6iSFJaMYzLwzdNIGGALbPY091iVrw4d5R8aOfArrETSXU8
         URpw6hFaejR1VCRgIMvO/OX9eKG2mlJrqB7baEDUiqbZmjNc1frA5PDz9WYYzgdE0FFq
         zy5+s4KaEpXSd6gmbdIw7XGZRMUpqwUYh9ES93Ob7tJ9c03a0IIFDfRSuQtK+ANj+9vW
         zCNPhyFiX4j32M23p1q5a8FvXP0sCeeK/ZRpGxl0uAmt5vhCLPwNI+tA7UpoE8kscTf/
         13Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXBNlCjhodA7qyg0AG5TGawLNlhUhgc34T7q+aGze3kTEhZMrOB47UJdnlZP5BdbHJDNi8xEi+n5V6XUhebEfB9@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWLqGBxASQbeY8o+rqg9sxXrjIWmPG9CMwEkKODplxQRjIfYe
	M+YAVuCLHa7p3P6LYvI5HzetrN+zRslQi5QCVr3gwP1mxuOazc/a81Hc
X-Gm-Gg: ASbGncsRwwdnEm4/wx4cu+XsDeqOg6gEuIEo5M7ZJ/1f+TQT++mHYUPlSKagFxPftoy
	SkA6T46uLocd8XbtvvmqSMESadAwIblzpBw4jwDDPKW34dz5QsVUQbLI1n6mWCb2+iJ1KSFQQ6+
	nG+jT6lUVs3lp8B5f7zuAVDlCWkZ+pIbkf280264dCvYs6whSMSqcKUJvESvd8OMnBUSbcM0Sij
	3cYBgmtJGpPfKl9c4WXwtQ4DhjlgAwsYDsOFOtJ3uN3+ZQYt35ZHPEQNGRN2pP07HKGbCbYGZXN
	HhkAxdH7RxOStaXOY3R1eApL0MKUMc3I6iBXgNgYrl/GxWp5zHlwsu4jfAcnp0h5uEz4tUM/LO9
	OlTdKfU0gQtsfJwKHDqzvShn4u7Aa
X-Google-Smtp-Source: AGHT+IHKkkC3QM8coQ6NO9qeJrC1prXGkBNL6WrXbhaljz4l9tRVx5lZNhS337M4qjUvBRHY2zyeNg==
X-Received: by 2002:a17:90b:3890:b0:32b:92d7:5cb2 with SMTP id 98e67ed59e1d1-32de4e70fabmr3469839a91.1.1757745320701;
        Fri, 12 Sep 2025 23:35:20 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:85d:f376:d78:d2b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b7b53sm6453910a12.7.2025.09.12.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:35:19 -0700 (PDT)
Date: Fri, 12 Sep 2025 20:35:12 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] perf/x86/amd/uncore: use kcalloc() instead of multiplication
Message-ID: <455fb1db8ab0811d2336e0ec198c728a0c703be9.1757744812.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtx2otpa3et5sln5"
Content-Disposition: inline


--qtx2otpa3et5sln5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] perf/x86/amd/uncore: use kcalloc() instead of multiplication
MIME-Version: 1.0

Dynamic size calculations should not be performed in allocator
function arguments due to overflow risk.

Use kcalloc() instead of multiplication in the first argument
of kzalloc().

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 arch/x86/events/amd/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e8b6af199c738eb00b..d08e3054461f2ca07a 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1036,11 +1036,11 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *unco=
re, unsigned int cpu)
 		group_num_pmus[gid] =3D hweight32(info.split.aux_data);
 		group_num_pmcs[gid] =3D info.split.num_pmcs;
 		uncore->num_pmus +=3D group_num_pmus[gid];
 	}
=20
-	uncore->pmus =3D kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
+	uncore->pmus =3D kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
 			       GFP_KERNEL);
 	if (!uncore->pmus) {
 		uncore->num_pmus =3D 0;
 		goto done;
 	}
--=20
Cheers,
Joey Pabalinas


--qtx2otpa3et5sln5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmjFEKAACgkQqoHu9CTx
owIXpxAAjaO0yrfiWXht/rwuJg+nIcjL6lDzl5QbIruCyZ57rrETsm1VsVvrx+fm
KFwjQhmJmPSF0m7Zh7yRtbgMvR5ADZ+C9no0CNvTtihrrIO5tJRPZqKJDcbWt/5P
vFpYvE0HO3nFhB5jSKSM32Cavn3GvVjbkgJHTAIVts880qylg/tNgnpFFrWo5wYw
KPPhksYPLkxsuBA5dQKF54qB6RyMGt3TCKQYwwU4oxoIBrtXux/Db2q5cCRYb23Q
f469XWF0UxuEZlimxjs1h6XWEnmXuBLMFhdLRdutU5VKZxnYNOLzbcvIqg425yJh
BxzIUm2Z8WYIQdxmtx5B6Z04qnLuXyJ9fuz+VO34X9MI7fRIFsPmRcu8OhVYLFvx
JELIQLKzQ4Rpi6//2jEgKgozwUrDNrF9Od3za66qqpJCPpOZsyFcFAuzIhYyTZtE
P1LrrG08RmEZwlZ/9+1sAaKVNFko3n+ttO12+xkQD/7fNw2T+UEeQ1URwocLvvuw
V/0ZSckdIm8kbuUckBFmjTbY0UnJdp6sJbSg/pXpMrhFyB4XBqgJdAMDwd5bbxkv
xySiGG7Os9R+v3GziyiFJ9RoyjJrl2wrQ4RzOhpoMBJ1wIcj5Lfhs1woq3Lm3K+d
RdZOwTalO25NWvX3nbVzSnLfiyZmevYV6CCQXUoKCpJEyAeR8OE=
=cHp3
-----END PGP SIGNATURE-----

--qtx2otpa3et5sln5--
