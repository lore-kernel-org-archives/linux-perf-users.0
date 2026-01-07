Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8734E74B
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810354; cv=none; b=HYhcRrfmxV0tPCI+MAp7D6HX1RlCjaE+h7g4Fzn74VG9BUZQ4MCIzE8TBOmaCx597fvpFFPMIgCtuRpe7rO+m9Zwh8abWjc1ZhjqJOWA3gbXdYcQe9yyWZqN1kEbWmzQlfsiZAu0pyKQVtsqdrihb/y3XvgjR+OQYYiQk8NsmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810354; c=relaxed/simple;
	bh=ybEPjNiCcRdCpRYzCY5DgOBnbB6QnavjJa8i03eIIHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eq40uDkxF4+EZsliPFbqT2Zs/Ekk0GTLWwWwxrsEUSTahn5pJocFcW7PSzf1GkAr74KObufeVu3Yzxgjy+BsFfTWzrwinKO/nlAXLBp8MKH6CxwFYLBT7aJzWiV/Wiw/S5VTqfAQHLfx8F3sRXfcoj4sQhcVcl3klqeB4yYmxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5y/gHkq; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5y/gHkq"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12055b489e0so184528c88.3
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jan 2026 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767810349; x=1768415149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmfEsx13S+5kgIulBTXHS49So/qNF3mV7k/YhgXr2wY=;
        b=J5y/gHkqUaWhRQesKtB+OnSmUicYT9+9mZyuzAW8BsY/kHqIFvnn7uWw7mbSrHwHNC
         5Oc+Ot26GqxxSEMpDfmg10bSKmbSTandlGAqCzCZHDPJfYdKcoTCcdWwEF+Nz45/VUCX
         BajxGKWzlXU7j5Qu4UC8IXc2AVBZt7/hsoUyCVJpTEYiy7VPrxsFYlLcx3HWG42Krg9d
         fDUYb16w4Cg6sz/3S8Hc+HUbbuo9f6gSNawwmnLgLjFBHZGnu6rI20mk+xPV2Iua97Et
         BIqok47GrbLQv3Zf9Oy5O31EgWNS43NAPrrxJzBILZ2/X1MfPKQVNx6Nnbn+7yK4gYzy
         l9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767810349; x=1768415149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmfEsx13S+5kgIulBTXHS49So/qNF3mV7k/YhgXr2wY=;
        b=KuZjEyXDcZhGtLlMXSn8ENi7mwXj7NcvsQiTCNaSk7O/FXID0FW2KxJNmxB6g6LjKe
         r1NzWotOG1Sg3KJSE2dys8PdfxogtLSxryi+mMFSPU7iIE7loRXWpBCyUwGUpiAc3C17
         ft0kYDMW/MTXWXKICaCXW3zG9ttfReUTyzUSku2uFy0klvFvOrO7n1730gfDsIolcnhZ
         FrD+svO/QvS1vrkGTvz7l0y54jRPvS7GiAlVQS1oVRdjg5LDL6y8gLy82inX6nWwh3WM
         znKuDtJ9HZx5Sl6shBZewZjHN2rdGppz+nzUnovNh9WWp+7tNGp0ww427u6ezSVBzIas
         DDtA==
X-Forwarded-Encrypted: i=1; AJvYcCW8+Dc1tDEJ3yFYjxttbmJ7soJ9kCBtpENVnzXSCXbnaO/54VQbwR7mhCnKtuo4Uak8z218DqnJg98myqRbuym8@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWfrIG+aj28rd3z6J1YgaaJ2sdK/m3+Xv7C3uamgaNoBT1FjO
	FBlg8+h1cxqGqOHKaLoWGJxOC9pnRnxquXNpWLtSHqu9qQGdERGX0YySV3Jmjl1g/y4LNzoJWQq
	KViuuG8wTT5o/hY2G0u20JSGt7mBJ+Ws=
X-Gm-Gg: AY/fxX5I4QqyyIuHr+UTHxJNxEFTbdEX8wj1DFsvxjEoKgrLYkax9zokxZc7cc7G9Mf
	OZSXuF7O9YxUqmTxMYZJBfpv41pj7NbL99kZYnKZziZFXY+h8e8MZITfnAudTFG68jH4c4A3eQ0
	oSj4IaGw9X1BjQYA7xxAlLz7tUewsVaRXiqztJleKXRzzQt6qJD6jX133N5I8EZ5cd8Ujic/2uA
	Ar/WGelHRD19+c3Quj/MKs7qv9HFpq6IlHtrgnx1jluwD0Gufv2U9h9jfQFtB2PAEtfqY/RwvAE
	/Rbp326gNfLF6wUy1zhWN+KwyE8e3KRPiTqA/FVX8sNmkRDARIMA5zzNP6EI+MzSHeFvbJfUx1l
	DKungGaaJxH45
X-Google-Smtp-Source: AGHT+IGUDU/qL1SPLoEQWykHXJpeBGHaPkJcYB9RKlfTVR1z+y/ggYx5S8IleeGfmdBq1UwTKzePqZHdAag6kIsA54Y=
X-Received: by 2002:a05:7301:100f:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b17d30df86mr1335115eec.4.1767810348898; Wed, 07 Jan 2026
 10:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105150106.567830-1-gary@kernel.org> <aVvdt90YmhJz3i5i@x1>
 <aV4TkNE_hAyByISq@google.com> <CANiq72kUVvMznfFtcjks=0iJ7HE2uvCSyD-Xu5NV=_9ZykVXhg@mail.gmail.com>
 <aV6kcMzcwF0tLpgt@google.com>
In-Reply-To: <aV6kcMzcwF0tLpgt@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 7 Jan 2026 19:25:35 +0100
X-Gm-Features: AQt7F2oz7iCeRNKU58YjiBKyOfwUd4yNEZcp12hZyyVHQKijn8HMEt2KMzBLias
Message-ID: <CANiq72kgcv4PBBD4hiA5Z0a4J9g3uSeeM=n0cu5efsCjuaxyvw@mail.gmail.com>
Subject: Re: [PATCH v2] perf symbol: remove Rust symbol workarounds
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Yep, perf userspace can be released separate with the kernel and it's
> recommended to run the latest version regardless of kernel versions.
> So from the tools perspective, it should support any kernels.
>
> Thanks for your work!  I think it should be fine once the backports land
> to distro kernels.

Got it, thanks!

Cheers,
Miguel
