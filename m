Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE135963
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Aug 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053587; cv=none; b=H5txNWBvP+zCAmfdRAhde0lUM1bblDw7h813L9RoffPw+rNQx/cZ17FtL7BcZuVJKNas2frUE5YoylInPIeMpig04eJLaFX9a4YEl77Y6dVN1MjywFpkBTElSdmCwmBMxewvOjYMphnFrltT04mpAno92HCumanftGbnLnVcaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053587; c=relaxed/simple;
	bh=rzbrFRokTuoA/BGlN6chg/kU+YDV0lrR5n5SZHBY0yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHtih9hrSzCmmTFvRKY3RdrgsrgOJQ90mZLhFM16HGbCNuGlCKO3DrE7hqOVH3JD9BWoH3+YYlvx8m75opG+djdkbQPj1CZujfFkmak4xmgHaNYWzbUUVqnialL5kFqM7jEheoWg8Y594iHxd1KfaE4SjgdB7GccuUEJ6bkOmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Op9ejKhW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Op9ejKhW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-246013de800so191075ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Aug 2025 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756053586; x=1756658386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzbrFRokTuoA/BGlN6chg/kU+YDV0lrR5n5SZHBY0yw=;
        b=Op9ejKhWjCevJKaYaa50JJDt8i5ttXRG6lPWM02X0teKKUHFlgtSuVHGRGa/ipaMZE
         9SgdRNNWL0wlkaK3itONtonk6n2i29qryp6yCJ27rNwNtdtHjahSc7myvB9O8QvHTXKQ
         H8zzNTvc8BEnCCCLZa2ow67GjdxN7XNKc4z9ouZT6WQtLjz0RjoqGXMqWk2uW/yn4b0F
         ALl2vTOE6oEccYuyDR1tUgbrtd5Zd561C2TvhD2IuHdEAoCNOv0e5+iDXDTdh4k+pjYm
         l/LclS3z8tUjl+nlICti/GjqmgHTAt4zL6Tw+9/OWZZ89Jb0yXYbHcSTlbl2aOjwJnTb
         7nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756053586; x=1756658386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzbrFRokTuoA/BGlN6chg/kU+YDV0lrR5n5SZHBY0yw=;
        b=JhKk44RuwmnbgxqL2Ra+8nHsr4vnJkEhtC8gx7elQhgYS6PsGUvfsZqPqzrPvemXOn
         oyfT287qKY18GILTOaZ4W1ALUfv0ZYIUcDIi9l1rn/ZGKF8JwpbknHX5VCZs5C7iAho2
         79iRMH03REGkLlRpzdHsyfFECBD+Wi0N29eT/zqWWlh67V6lDhGR/z4jBLz5yKxW6aUx
         knG+/jZVV7lIleUcYZhsE7QddvuT91RP+5M7gu8QlLFNtRhh06GiOBCgaV+NVMnHkLuw
         NncDb1bRilYKy0+IwUC8OOjUDT4+zP/El/ZvvOEHRnsvQJaY6DvMlPY651ZC8HFcH4Mf
         W1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXPotjYofYOcLMUe94yQBzyD6mPr3P4nMLcrG8bqweafBzWlDe7N8afAHLWZWH3/Y54VKL5TdOl6h0/41xEf8cO@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBgdk+MMiJCNDRl6S+wf/f04SQ3swLTRXBwHLF5uUyqP+6Jgs
	h8UzJ2cOQIl0sQMGSgEI3of1aIV2lUQhC1bkIqpTCTtX6F4+woc9HgiMHChodKWBDvf+l9fNe5H
	nlJD+iPUc1vOHvYOx6lVR8/hx9yYLNiRlsS4RPG1O
X-Gm-Gg: ASbGncud5jg7DU4wd+8JbDig+q/zEBe/eApEEy114IcwEUJ9pQJWYc2sJhr45hnQujL
	TxmS2R3menZ2m+QVFh10t/PeJ4mtQAXsWqkkAIxgneEcaYq4ZwtS6f1BlxjN5YO6P1xIwdbUEt/
	FAoc+1ucKvg/q0CjRzMllsabSj+J7oh/qGKNBzdIiLqGFp4tx0v4E/WM9ORJCgpjjCBxUIrzifq
	jG+sPd29R/ptrdgEbioSpn96A==
X-Google-Smtp-Source: AGHT+IF8ztkEHXB7jHNLH5b0qoR949xdKvlTltrfHLNI9mn4T2PAdsWoPgL0Nz5jySsDqNoznj8VNBGkS1VgvZI1Uk4=
X-Received: by 2002:a17:902:cecc:b0:236:7079:fb10 with SMTP id
 d9443c01a7336-2467a21e4c1mr3101485ad.3.1756053585241; Sun, 24 Aug 2025
 09:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com> <aKpP8yn7hoyQJe9h@tassilo>
In-Reply-To: <aKpP8yn7hoyQJe9h@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Sun, 24 Aug 2025 09:39:33 -0700
X-Gm-Features: Ac12FXzo4nNl7CWXzsGv5Kuj8o4HmwvIozQ_8cCU8zkwDdeVOkH53u0lihj7JbY
Message-ID: <CAP-5=fUa6xcn7j6_SGrmK7pTPTcUADodXo6o3UTLbFWBAeUUAg@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 4:34=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > BUILD_NONDISTRO is used to build perf against the license incompatible
> > libbfd and libiberty libraries. As this has been opt-in for nearly 2
> > years, commit dd317df07207 ("perf build: Make binutil libraries opt
> > in"), remove the code to simplify the code base.
>
> The last time I tried the LLVM stuff was totally broken, couldn't
> resolve many things. The only workaround was to go back to the actually
> working libbfd. Please don't remove the only working option.

Andi, did you report a bug? Does the non-libbfd stuff work? Yes, as
every distribution has shipped it since binutils went to GPLv3 (in
2007?). While I don't want LLVM stuff not to work, bugs happen, libbfd
is license incompatible with GPLv2 and maintaining it in the source
tree is a burden. When something doesn't work, create a test to repeat
the issue and then we can make it work and ensure it doesn't break
again. In general I've not had issues with the LLVM code.

Thanks,
Ian
