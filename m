Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3135F60B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658621; cv=pass; b=ZaCZmG62JdprX0l6jOB2WEuxOEmp6oLyvzdhiz7RnO+RkfnbT6JjZhhQMdKoxZfkHp89BPI3cD4G8HgVP3Xvd/fcOCGOkaFuafc+7eCDvnFu3vdZEXpnPn558JlRyzxfL1PHyIXkXUD/trdUhQ8XUtlR8+CyZvS3HrbUuAgieE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658621; c=relaxed/simple;
	bh=1x0qGC1z7KcL2RcQBZrnk2++6hcdnbvAAqaO2AwfRBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScFti3K+AEA0cjDBo6Il76IECCx3+fXabQAJ+ukvW338Wzu1xxoWJJWAEqA9sqYJ+UibzNXeVCAzfhByYIPbkfclU5o7cHBIhmP6aB8gdDp6JxHq219GvrZLJYWg1ZuRg0vXGfIQVWPWlLBzIQp/d5LMCg2YQAKJLih1oKwM1VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+KgSh+v; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+KgSh+v"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4b40999bso3275ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 13:10:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772658618; cv=none;
        d=google.com; s=arc-20240605;
        b=gaU/cBnh5F+T4vsA9M6D5EbBWiTncQ3zL4dml3YRZOsR3+nfb85bRKZ0mnv4j37wGN
         Or2jwZ0Y60s1wRh5NudKma7NITdQ9XzRvIuWZ3si9i/PXAwWp6+k+ZJXpzBknzoz0OQr
         aEMCwyCCFI3kqKbpaU89KTaRvHPoLUgdCIjL6cJnNHLSKlLcovjpgPcrKfYQajAEba4J
         QThT1ToaIbXdDIUGwa4NSPRqTQCeLOkNIxMLJZGou7nTrrZV3FGHNmqK95W6lbRoJhqa
         5TSuL4sPD6S3K6aORwrOHkJ8HUhagItSrhNmahGRDBOuU/eocpjUOvYq+bK+3jJZrLGr
         6xWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1x0qGC1z7KcL2RcQBZrnk2++6hcdnbvAAqaO2AwfRBU=;
        fh=JNrLPChPvLkbn3ZRw5ofH0eWOVNZbWjNQdpe/rAyu+I=;
        b=bRomKLLRTUEdBvzjwb5UOZlRxsYqyq4pJsHacUZhvEPdj3mgLjcmoaFSRnQEqjJ0qX
         nVSnMMqhZWDQEvxhhzNa4cu4ZmHS6e1c8un/fqaY9VPM02pcdD6C+h135+g+pThfggN4
         Nv1i/ptmUyLXTg9Moj+hs6n60I43jsWoLsbsHNx5Z49wCFBcQ8Jh2t6J5Q2xU75A6BPj
         /jg8/qF3Ry6Z9nSsVGjaBNsmojbBRdMbNFGGLkL4K3rcQPcXj8tHn3ccMv2fMFLnuse8
         GVGBW+yBp93vOl6Nv8bonm+6Px76NHz6nEYSdWovvmcQ5/qc8mdjmZnqE8WugUyCm4PB
         vH8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772658618; x=1773263418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x0qGC1z7KcL2RcQBZrnk2++6hcdnbvAAqaO2AwfRBU=;
        b=M+KgSh+vtDdoP6mK5BaE5+IR7MGunYuYT46SCKXyM1mvvsMyJPeyuuUpJeEIkasPYl
         qfNa3A/Zz2IjRx7bQh64OMBDBg8bma1mZPFJ1oAH/aRZvpRz9wA2m/cbifFYhXpGiUuz
         267FPobi0dZS5YTgazDZKVYPWugjnutVbKnGbxNij2pypVqNOlQNFHWSSifzLVsdeaje
         +ySyGsE7zkJuIcyhxp2F+dBihJKXb6MfOjLNyuqIolPz7OpbVLUHYcdC+sHb4lq0DZlD
         yO6cBEOd31zslP0oa7bA6FI9cX1rvcxKLd+Rkee5ToEbKK0UzBQPYZ/+v/3VeFqT79rW
         cRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772658618; x=1773263418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x0qGC1z7KcL2RcQBZrnk2++6hcdnbvAAqaO2AwfRBU=;
        b=H03WbxoRd8DDdmfdBbTxzwUsGlAM5uOaYm9S9f8lV2dqe3hxhyFayL2pxU3iGdwDlI
         z/R8h9bKJordD9rDCTtkldgJO2rPoACXvgoVQ9e2p17LbWwiPgySJ7o+IYjs7l//tsaB
         sCMGi3/wEYEZSbg4qmfNR9m1y0Jty6qSpCOYIvYAA3DJ7pzV5dFfxSolX90ZVYBPCV54
         9w9plyfJn5holl1gc4nskDws1n0P+39mvq1zHbXb0VY6sPehezdpz8IhQCZqT2LagLzV
         UrnKK4+Vd741AgXb7HrmGGnEOraf18czYG5dBun3r6lDOmvYPIarnsRxATyFTRpozgqs
         FVqg==
X-Forwarded-Encrypted: i=1; AJvYcCU5OzLGBxtKo0l/RsFerGQdfSmTjPJJ/pgvnmRHucx1/gvsWFaUd9/+N1fqzHqXKng7EXpOTH07C/gy1hNmh/DZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05Jb8o6eoj2xnL2P5TBOiGOnUOypCAFZM/BfmpAK+Xe9ABBG0
	NNbaVn2c6SKUhiuvL154Kccn2shScqUfFTaaU6Fnxtm7rsmJZaCAtn8+f2cHZv3j5Kr+xn+LkGU
	0oAeuL3uN49zdHHV6TqboGWV57wMNRcdBtl8T1Ba6
X-Gm-Gg: ATEYQzyBOX+TIKG1SkQMg3bBMV8acZ0qec6oYlPl/xIgPrOp6R1GX3JyXgaxRvpiWkZ
	eNt3ZKemp4BauagHf71qjYAdD7roifMCv7hdD6aOAfZr0Y0FQiooz5GduYHkfq/7XsP3MLqg5hq
	qYGT0t4nuvtAkw+SrfAiJM9WpcoldnX2d72SGHDDEEPB67Zomf63bwP5llEuY0jR+miaLdNOE/n
	EJZOaIadthJ7vmCdkG7o2+bv0gK2c/SP779SOat1t/Mea/D8P2zl3WbKbVMefXyHoPVINwFUkes
	qCmr/Phskv/UCYtj0xym7pG/Gg+OppcvBxTX
X-Received: by 2002:a17:903:2291:b0:2a0:89b0:71d7 with SMTP id
 d9443c01a7336-2ae75200aa6mr154585ad.13.1772658617476; Wed, 04 Mar 2026
 13:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303230043.2074593-1-pcc@google.com> <CAP-5=fWL0jKGQuqBzP0xMWVkzu48c6JzgwWQ1+NkAxgbpSPpcg@mail.gmail.com>
In-Reply-To: <CAP-5=fWL0jKGQuqBzP0xMWVkzu48c6JzgwWQ1+NkAxgbpSPpcg@mail.gmail.com>
From: Peter Collingbourne <pcc@google.com>
Date: Wed, 4 Mar 2026 13:10:02 -0800
X-Gm-Features: AaiRm51Ju52tciadDjfjY4seviPZ2A98iFg4I_8xpLY0b4aTjYIkv461rYRYz3k
Message-ID: <CAMn1gO6ojcmH-aciLT8XCMPMx8LaNSpUDzAWGjTUp1kGnwMd4w@mail.gmail.com>
Subject: Re: [PATCH] perf llvm: Clean up after a failed disassembly
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 3:29=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Mar 3, 2026 at 3:00=E2=80=AFPM Peter Collingbourne <pcc@google.co=
m> wrote:
> >
> > An error returned from a failed backend will cause perf to call the nex=
t
> > backend. If the error happens mid-function, e.g. due to an unrecognized
> > instruction, we will end up with duplicated instructions in the output
> > unless the backend that failed deletes any instructions that it created
> > before failing. The capstone backend was already doing this but the LLV=
M
> > backend was not; fix it.
> >
> > Link: https://linux-review.googlesource.com/id/I377eef3cd662ab98fbcd69e=
5004a259fa3d7aa06
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the review. I guess this one should have also had

Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")

Peter
