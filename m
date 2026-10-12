Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BC4BA1F3
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841556; cv=pass; b=fHLfMjSdlK7ZJM/iLe9+BoOzPljBI1UBWTEhnkOGpLTqrLqwEKvQ8B37ghTp59XRdKUL134mJIr5rchQ8tXH9Ah929labqShy9hQkaB/W8tuXpGUplQtbU8iNewK8JOUyDIHrj6xGDXYkIZ193/6VoJkuSI98dFzYODUhfmYpvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841556; c=relaxed/simple;
	bh=w0qc2CZd4Oa/lsOFggfocUkyp5cgiPaQh1jfXgSkSQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by2RjVOsk2QkD+pT8piwXcsokNi+74ZifKFaVr6jsu13hj2togc0vgsWqPd53fv15h+wZ2SVWJCeeeUZaA6DshPMhQQNz6XdYQEdBywHD50i6USqF+peYY9YR+G6GfnkPzVn3b1Z7Yk6/FOgz+3JfEIC9BjX1aCj7e1+SnioVVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb9Msbdq; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb9Msbdq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5337c7b9937so541531cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791841554; cv=none;
        d=google.com; s=arc-20260327;
        b=Caug0vGzxKO65Kg/0+hpTbuIziSHq+0SflvqqQBHRQhB81ckHge+AFdSRP4H3Nx9t8
         xGnhgKC0BLtcVCsommDHiaKk73OUDxABHqQRyMUhkppMjYQTNI+fZYtEa3KP58Wk/Oha
         PuEU4wHobKHZT7MCp4rFnreG88NbKwQdvjpwclT3m+s5do/wan0ORrcCRGHsIQe80kdz
         1ZaYQS09W0dXvc1LA+JjHWwc8p09U9zR86Cv6pQ+/RnzBbA28j/kxyp8Ut0ymxQX4xzz
         KHla5SrVFlqUbXYw2dZAeS4K5piPrqA6XMdYgKP5u+Rpa656imsRnJzb+O/16fEwhKkI
         1Img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w0qc2CZd4Oa/lsOFggfocUkyp5cgiPaQh1jfXgSkSQA=;
        fh=NcE49uiX+r6NMGNCwUYp7PEobMne2qUbu6O3Pf4s99U=;
        b=nf3Qrszx07qTMu1h0wyYEbQ66NU/OE4pAIHHR7M8StlTDOd8bnoIlNFUivVMLWmkvC
         1z81LPsZSpHrVfxAiEztkval8oXFaCZ8L5mePsgGz1vIn/XX1CLZQnb2QB16zvonkCA5
         x9pegAtBhDdX0U1LPt0N2qYpbNYHg/JYtcYpZjY2BGUt1QjOVzTfoZbupG+0UQdp7ANQ
         K2iYNGm4vYVCVFZR3ZhhfH0BIHx2PKSoWbh2Yiz02g2RIyU/obHennlbp6x+Nt5U8RMr
         b/vk6vm0hytAwW5rmV2iPy9GkCsLyZ2eyrwPL8hnhv9qeP/ax+3w3An/vA9u7wRLEJ/3
         64bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791841554; x=1792446354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w0qc2CZd4Oa/lsOFggfocUkyp5cgiPaQh1jfXgSkSQA=;
        b=Cb9MsbdqZseVKss4qKjrRHqmyH/0yT0HG/9h0rVLI249Thyclm7QQeYchd1NPIhs/k
         DPRrvsokjYPw4lZWztWA8O8n/NI5NHrsLEsRLi+CYIG+niX+JLP1VeTYr+88dyx44YvW
         NLj5jhJWdKBh+doOsW0qDtSIrlFa8zFfmwaerjmzU4xq+6JeVVEqhNLX1466yEvFNs99
         r8AJp/3mvH/63o9GGe9NqLcdpkGfeJJmDV6Lr8w+GCwksHaxlVWJBH/HKILnTQdZqC5P
         ov099KLBxFTvmL2R4I10m4vNP/78XkNVNO/65N7i8uJR2J4sxfStkJFPyaq0KeyGQFSa
         VutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841554; x=1792446354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0qc2CZd4Oa/lsOFggfocUkyp5cgiPaQh1jfXgSkSQA=;
        b=l7k80mWad1NIo/wWzladulVavvhKN0LQgrPlzUqPETI7KklKIGIsXfabhjmXTgwpvb
         7Fx8DM+FLGNTBUP9yCihWtsK1T1THw2k45siB0R68dHrxdXVX5qNlpbaS8prW7I8lE/2
         Idzajxij71pWHttS0dyGasr4+e3k50l/gHOXLmL599f5bcBb6ft/dI/ieTKPAiZRuzpj
         Ju+UZLS58X3++2CXZ4udDepnDI0R8Jf+znA2nekD7y64j1La7lteXxeI0Y72mP+AgxIl
         3sniY/IiQL+NkB8pZCK2R95AUbWeuGnqL3DAX6jUpK2uxYmkX39yqvCX/hwYTmNGNyXW
         Z9Og==
X-Forwarded-Encrypted: i=1; AKwUvBwpzp2glYzetr2Ai81ifwQl9xD08mtYX3KezE80NUwMHVNoee/EeNPWuz0JdPFSlTGdvqpspHrA860Zs7iV78Bo@vger.kernel.org
X-Gm-Message-State: AFq9FYJUJKyuogMVKaLypnjZyGx+NxT1E269BidNcvDBD6oe4czUOayK
	6by37ohewGAClgb+nnycss7azedZlCfHaxB82f4xpR2uTlTxkJ14pL5Xxoh3OZSdmjvbZ6DG4/Q
	KW1G05/6IEtGe3+iYTJtskN69IFnwodQJTYNwd6TK
X-Gm-Gg: AYBFou3YuhfIm9T4Y7u0f45SZKHNxWTO3zVG6DdiDAMXtQKjaQMqPCwxoHkX+hB0X7A
	WUE3ZYpGKiy4wUr/xk1Kq6cPe8WsgsuDh85390ztDozPykyu83ctz4lLZNi85QeDVX3yQAGjNyw
	NjwmzBL4TBpni23Fr+/V5af8xGoaVctXdRGAFMA/V2cwvWziJbdu0qNQ/0bAYoHKEtVyWckZDDm
	fL22qTj6nc9r92M/tgd3el2LGb98ingwqlk4HWp8SzcBe7QlV/MiY1tS3AuK7QbmsNlaLrEZ3b2
	0vM44AXPgCDdldptISfv5AH76Nm31JCFE6gaNjHvN8lyBMds+wyoxhkBvAJxhVaswy/nqyfYbGy
	toyz5zBSvnshOGzSYklCh
X-Received: by 2002:ac8:5a95:0:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-535b4ecdaa4mr34353401cf.8.1791841553813; Mon, 12 Oct 2026
 14:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
 <CA+=Fv5SDnzQQDzyhaQ37kWJMjTOHP0NHuAS6kJHwT8_Zqyjd-w@mail.gmail.com> <CA+=Fv5RGr2NQs=gnErAWXfSZgMcWB1q-_-BNQ5X5DyzqkV-bmQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5RGr2NQs=gnErAWXfSZgMcWB1q-_-BNQ5X5DyzqkV-bmQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:45:41 -0700
X-Gm-Features: AclHuK-KhF7SQQ_cSO4Vi6bo7ImPeruAfj2YPIigck0H0gWHJJaIzIY69ZpCKsw
Message-ID: <CAP-5=fXFYbuV9MtJsVX5hUPKDOxcjtNTHM4-qR7Q+ncsPq59UQ@mail.gmail.com>
Subject: Re: [PATCH] perf regs: Add alpha support
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Matt Turner <mattst88@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 2:41=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
>
> Hi again,
>
> On Mon, Oct 12, 2026 at 7:37=E2=80=AFPM Magnus Lindholm <linmag7@gmail.co=
m> wrote:
> > > base-commit: bc01105ed65d15787b2eb93ac26e8624a2139e35
> > > change-id: 20261001-alpha-perf-tools-regs-c206a84dec7f
> > >
> > > Best regards,
> > > --
> > > Matt Turner <mattst88@gmail.com>
> > >
> >
> > Thanks for doing this!
> >
> > Register selection, recording, decoding and user stack dumps tested
> > on my ES40. End-to-end DWARF unwinding remains unverified because the
> > installed elfutils 0.195 lacks Alpha unwinding support.
> >
> > Tested-by: Magnus Lindholm <linmag7@gmail.com>
>
> I just pulled your elfutils patches and ran some more tests.
> With your elfutils patches, DWARF unwinding now works on my ES40.
> Both existing and fresh perf recordings recovered the expected
> leaf -> middle -> outer -> main call chain.
>
> As documented, samples whose CFA depends on r15 stopped at the
> sampled frame, since r15 is unavailable. Tested-by tag already given
> to this series.

I'm finding this fantastic and exciting to follow! Being greedy, does
the cross-platform DWARF unwinding work? perf record on an alpha and
perf report on, say, an x86. It would in no way block this work, but
I'm keen to check Matt/I wired this up properly :-)

Thanks,
Ian

> Thanks,
> Magnus
