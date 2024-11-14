Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9C18132A
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609077; cv=none; b=HX5CqkXIPBUVQlRGvMBIgKbIFhZTdP2ivaamSftprEZxeSpvrxr5qwN5ZNN5ePrHGsfh4Vh9sop7OcaIfuvCiixcClHrdLKFVAb9Cnjmr9q8lcNbdxDPoE4dtYIG6kXc96+ABDRcC43dn0v3albFvqdognmr2ElFCLiqndm+EPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609077; c=relaxed/simple;
	bh=qPgttRKqIwbel5Escl1oq0suAUqJ6hGmn2l42WFD7Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT3zEhCrHyBH4plFUg5/RSsiXwgOokr+/1dwbJRSszz0vUyEhXmoFVf8P3CUFVZC1Rvish9lQ2S8YiL4hXXOJxg1w1nwTsce4WDvM7WbhAPjE7Fu9jI82cASUMps72c8f5T/pNH9KPH7hy4mB/Rh5vKfE4iVNJpUh46ZgQ+CtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/abG7aR; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/abG7aR"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a71ef98bc4so7775ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731609075; x=1732213875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPgttRKqIwbel5Escl1oq0suAUqJ6hGmn2l42WFD7Wk=;
        b=D/abG7aRzBAxHMtc6QhJ2JbWytpASw9PO/iS+5NxVsBvcWRce8xndB5GgGDsd26L90
         jht5feyGXxbsq9NNeVFusDyIA3viWyT0oNPK1JOtFPG5P2x98N5IrWihzseEyOXO+WT3
         ZtrGeBjG4Rfc24u1xofXl/GpcUMghRHZkdKbT/J0B2xzc90tnZrDkh2VdKdXnAqHf+id
         ORTFQgAUJZA4Mu3OqeDEOm5EfJdEN2Ed+qvzyPooylGXqZWrNx8jIV5CqjdoCSHdv7aB
         ruZCvbkTHCCGIMOTABjZnGsb6bmZSlXESc+I1fIUMRlZmIZzDxSY+zvfK1mCzAVmb1Ty
         414A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609075; x=1732213875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPgttRKqIwbel5Escl1oq0suAUqJ6hGmn2l42WFD7Wk=;
        b=IWOmxye9oj5PPcx/i5jj5IiDTvnUr/jEaaNzdS6DMXcKe8FFIDasUiJEtlWeA/LIAO
         lEB0uBuDDI22f/nC0Gzc60guw+EiOS5BzJx7CkEUQ7ek7aqlDFaAFnPBk9U6tlQIg8UK
         JNliYJ9a155c3y3gN7fA+InuXjD3dtioR8MbNAnWp7f1+XHhMwtw9PIHtdK3+Bow2Q2K
         kp+q6g0C2DcDbcdnmPx5Obotv/r3xmfhGBrjbOma7yhvQGukIfkmkEOPz4psphLMoyG7
         7K3b31HApJVix9Yc6PdWjXGQAXfRwha7i7AVR0ThT+l2qDL5SJgM4WIXU0BMzWwoIx7W
         EVwg==
X-Forwarded-Encrypted: i=1; AJvYcCWgE2UDuFpKgmnQnN5fK/Ra5yPUXnLEVj/fHsAwk8/AZV3YnYst/Ly5Qe1IkOPcxrfFukxTSr0UF7ew6ckz07QO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BS1T0vQDP2QdgYy5mee1uow4eaGF+llZxNeuHEcVK4j5Pc3H
	uD59DFlFZo8SIBRRYKhsV7yNxKnqT2lu+S9Q7uJmj6go+CYuDkUzdrfN9nnTVyIWXD6lfA7/EI9
	SrGb2wHjYj8QCzbhHEeY7OqlC1oYbtN++V6t/
X-Gm-Gg: ASbGncvBOcRZ4X0nwiFVFBP1y831jonNs2fYhApAUm71QZQbu5BDnKVlxQReEJRrlXf
	0NOMmOyWTABTJKI8zhejuVg2R+wGVBBZFpAzFjNwhau633CieE4wyVphr/zjRoeY=
X-Google-Smtp-Source: AGHT+IHbt2clAsvEm2GCWE3HZL8c9XYanWoYZmP6qTNs/eamsLOQaZgatLIMPvRuQ3+hmYVnmRaUTEoaA8PTfGw6NT4=
X-Received: by 2002:a05:6e02:1a4e:b0:3a6:af68:668a with SMTP id
 e9e14a558f8ab-3a71e7a2d67mr5483705ab.18.1731609075190; Thu, 14 Nov 2024
 10:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com> <20241108025535.wfhke3btch5af4fu@hippo>
In-Reply-To: <20241108025535.wfhke3btch5af4fu@hippo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Nov 2024 10:31:04 -0800
Message-ID: <CAP-5=fW=RXz-A=xndhs8wkXaKCz-qXB=PemAMvbZpUagvObUoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ben Zong-You Xie <ben717@andestech.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:57=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> On Thu, Nov 07, 2024 at 08:20:27AM -0800, Ian Rogers wrote:
> > Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> > lookup:
> > https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.ya=
ng_2@nxp.com/
> > These patches remove a lot of the logic relating CPUIDs to PMUs so
> > that the PMU isn't part of the question when finding a metric table.
> > For time reasons, it doesn't go as far as allowing system metrics
> > without a metric table as a metric table is needed for metrics to
> > refer to other metrics, and the refactoring of that resolution is a
> > hassle.
>
> For this patchset:
> Tested-by: Xu Yang <xu.yang_2@nxp.com>

Ping. Would be nice for this to land given the ARM fix and general cleanup.

Thanks,
Ian
