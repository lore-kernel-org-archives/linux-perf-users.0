Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C7180048;
	Wed, 17 Jul 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233692; cv=none; b=IPKNOXslzli6JTyvmM9QhMs7wg11JeNMYG1BVJr7wu7ci+/Mj5kMgnwhFK74NJLsXGvGP+uti6Wkxz11Po2zddAOC0uOK29cd1jz9deUrLiV7RmbzFvrrvdqJaJkZ6ZdHaR8xR+uzkb9vx1i7Oh4sn34upCaWHb+NSTpaYSIHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233692; c=relaxed/simple;
	bh=sB/YRxClJEebEODIuMzr0bvLjJ6lGLPm7u/XJnWwAt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A95VcQC05niSj9CuV2A5H4TYtmMcCLGuy975tozkZGwoBIOFLrA3HBS5+rRoLWqgblCBheTB/Pwz//UMQSFQTCsOlhEbMYLjKjU7Al9MtN+h8LCENSWZ2okNg6ROX7ZeLeM6QpzuJQmyV4wsBOzEf9yqK7jsRK/nHwZlermkGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b703eda27so3355886b3a.3;
        Wed, 17 Jul 2024 09:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233690; x=1721838490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB/YRxClJEebEODIuMzr0bvLjJ6lGLPm7u/XJnWwAt4=;
        b=TPfrZRrk9xjlFVHkwVr0KIlchyAg43gewAB+9ChnPawV88IBaLRbkn5ar10NOT+9XR
         X6nveGhoCPZCDlZPuV9SssGa9SyT4Q3JBhsBJbHX3iuzbFBFgGzne0PJBf3dU4afCnqW
         naU7IIOIfNWiVJRqOtMs4IHHIHDpKG2j1mifgze6alg+eYY7HcTqy/SNp8fqli6RpiNI
         Ee1ZHJMDIZeoftbPX14wvKpFjYBUJrVnr+Z50x+zf1mnQDl6WkQJtVIxJihnl0AmG8ft
         ErGy7YmCBQntQX5OE2wFTU6ZF6J/QbK3EnEv/iCgJqYB/dMRd6Sqc652/JwYFODlHG0f
         arZA==
X-Forwarded-Encrypted: i=1; AJvYcCWVbz9Pig7TF/afHBJo01QbLQ/sb8JHgx8Upt5v7uhytzBW6Lofg7pPVqwZ67mmdJHRzZGHz6paSccuoEN2gXBQYLfykbVahtJ9ezuKKJD8KyoyRhBM64Pg2hBt3/yGGsvWIYwOMH1m2XDBwPyVrg2444z0IiIOcKWvrYO335wcEHLydil/u0nMQYENatcsD1ScMQ==
X-Gm-Message-State: AOJu0Yx/NjGrGRXR13DM7/6b8sq4qby52s2Jews5lKgrULV/KHG1avf4
	JxtG/XoUYre6wglL1hjlOmhNgVO9aBJXGLb1irr/mgg0yq+zxPAHeI0jj34ZlTV7b+MPr8iF0Sg
	gNGPbFbZB5Kv01FE9Ufyca47WAMPRcQ==
X-Google-Smtp-Source: AGHT+IHn4SdMrZl58GaXhw538AFJ0+cWEFZNIW9lE84hY7Nv4nH4iyEjjPAcow2rjOUIeWKt/GVLe0JbhfEnf+hNKpA=
X-Received: by 2002:a05:6a20:258c:b0:1c2:9cbf:cc3e with SMTP id
 adf61e73a8af0-1c3fdd3bdffmr2833775637.45.1721233690022; Wed, 17 Jul 2024
 09:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM9d7ciLGP_w9YYOb-2U2ESg8kQx_knQXuB6_2JZVZ2ktL+bzg@mail.gmail.com>
 <20240712194511.3973899-1-amadio@gentoo.org>
In-Reply-To: <20240712194511.3973899-1-amadio@gentoo.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 17 Jul 2024 09:27:58 -0700
Message-ID: <CAM9d7cgG5WvyEu1ECNht1z=bZ7MSsrPyBjokcY95SXmxgnzwsA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf build: libtraceevent, libtracefs feature
 check with pkg-config
To: Guilherme Amadio <amadio@gentoo.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 12, 2024 at 12:45=E2=80=AFPM Guilherme Amadio <amadio@gentoo.or=
g> wrote:
>
> Hi Namhyung, Arnaldo,
>
> Here is version 3 of the patchset. I see the change to send output to dev=
null
> has already been applied, so I am submitting the remaining work only.
>
> The difference with previous changes is that in v3 rather than add tests =
with
> pkg-config to check if dependencies are actually installed, we just set t=
he
> flags and send any warning to devnull. The change that remains in this pa=
tchset
> is the fix for the other tools, which were inadvertently broken when the =
include
> for libtracefs changed from #include <tracefs/tracefs.h> to #include <tra=
cefs.h>
> since the flags for the feature check are not set in the other tools Make=
files,
> it currently only works for perf. I recommend to either take at least pat=
ch 2/5
> that moves setting the flags to tools/build/Makefile.feature or to revert=
 the two
> patches that have been applied. You can easily test the fix with the comm=
ands below:
>
> make -B -C tools/verification/rv VF=3D1
> make -B -C tools/tracing/latency VF=3D1
> make -B -C tools/tracing/rtla VF=3D1
>
> from the root of the repository. Only after the feature check flags are m=
oved to
> Makefile.feature that it also fixes the other tools. Apologies for the br=
eakage
> there.

Steve, are you ok with having this patchset in the perf-tools tree?

Thanks,
Namhyung
