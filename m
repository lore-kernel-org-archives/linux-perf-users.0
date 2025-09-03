Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE80296BA2
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932895; cv=none; b=mRn1fMpMXZZXrsTQJyGOTlC7LF2SHax2kNoudFiMT/Q0TVwXlH5uK42KaROcscDg9VIeaglch5pP5ycEt/U70nPCiV+Jyqj4uiT2gAKG3/h9evsytnRkyf2Q7AKDf85rAbocjoy8LlS74yM2w8NLTB6p5YT2gm6m9XrejTuE7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932895; c=relaxed/simple;
	bh=L/f3EFrAw09+O/f4UEAO4Ok+aRzLY87xvNEocmB8skg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmQ7sXZb/NLrQIauvVhKQH4t92phJ1qtunHgL080XFqo4ng9wj7EwQxqOxmu2icJABUuW5T3qzXqjNNQTIfTYpP2SEWVJqLq+4tntl1ZbV9mREUsnaNtIU22cWIlLg8HTqrS7lWG9XLHfsSC54qb7vap/Opz+pP5iWuRyrIt2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5yAoGCK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5yAoGCK"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so311551a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756932892; x=1757537692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PlibY4hkoznhQk7xjmUe2E9ZHsCDSlVQQXjHQI0tNM=;
        b=W5yAoGCKlj7HqPeuf87FhchKXM3cqQhJ6uc6ErGiJgiZ4ZsVNfh7zQxm/nimUI3ouI
         k4kxzzMN9gGFbMJ1S64FK/MmVGM3y1LK+6leOZpExiLuEVQqd0ktLISeyE0Cp2r1H4Vj
         jxsorNk/h4daW2urbax2e7Lxn4G7pj+46xWL53mTxNsEiOeVaYZiJhg/7pD8CwF6CaXx
         uGNJu2Ky1qT8Anv8dtj7G9LqPaA52/s/BG5Pu8cwZKHd71UdaOUf/5LR7fulfDK5/io5
         azlDkQZUUAfAQm3DW0SpZG9CsgwjMURuVQWPuApBsauPH43/Tx48ZmkL2KaSDFOeLrP8
         hYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932892; x=1757537692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PlibY4hkoznhQk7xjmUe2E9ZHsCDSlVQQXjHQI0tNM=;
        b=n8ULNvOol2u32C7yT78cblAB36UULvXSsEopvAemcpWyyGPxSgmxCA5EvI03swKaDt
         f8Uze20Pqe9Eaksy8mOFiPVL2JK3MB8t08XVt8RieDTv4NSeE4PaPqSwUnX16Av7kL5k
         h8MaHTUVLXMTYKestpQSNRP52CLCheJB4KwwxGTAI9Bv5cSkovD88y5JWNB4qnouMIlh
         YLTBIe5bBWsVkqBuhZr8VI5xteoht1y70Q1JQOKZqwQtFGrhOp9O6Y8ExzX4yxEFLo2s
         WWDvJCcq28BgHMKXZCOwxhuhA9vrq9+qbkzsU6ydZemFBmZB9gGzN6G1/ajtLTkb3O06
         rC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG+cHR8KOtAR0myeoj4wW8XTYjrDFNrWcmEMlYFwtSReB6Hxzxg1Ikxv07nYFbG/qeyyIGyZ47J07v4hwESs/r@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2f/Q5/AYTosIuJ/WNz1/HemS4tM8CbnWyW1IW0hAH0p90frO
	+t3BOXoqz+XJzE3nhTK6eZCnxBUh7DdS+pG17YPgSeP10wXD0gdPc3FNg0VLjFPohsUc/oj08vw
	dJP6fgSMbn33l/kDbB6G7MyRG9x9IojFolqtfOTM9
X-Gm-Gg: ASbGncu1nNxlmPVODLFfL9XlAz2G2BKAAoivs18v/8Jc6pmuTNXe8QQ8yViQOI9eS/O
	8yhTzHd0ZFyur6RE1EQPVzvrstVmh0YR/YHYWhzZt9+rKoOBLsaGxBYKCEOErI338qaaPmsC1Hl
	hLTTU+htejtDeH9FzynwvxYGGP894jybJ3s8PpQmVjzyiwwV6UUBYV9L2m+artDBzDd1a/3Ixew
	KHmvQG81p0Hxlny83RVvHHsdDcMQtjJHmP+Wj9AbdUm0gRC9yOQeCpyPrSNOBzrLQ==
X-Google-Smtp-Source: AGHT+IEI3Fx1TfPdtSP8cwFaLXhRsPNeMgppWmLkffm7Gt3QDYT8AObIIGU4tWbRSXgwRcjJ5KAuwFicXR3sHmkFDLk=
X-Received: by 2002:a17:906:1856:b0:b04:f5a:8c13 with SMTP id
 a640c23a62f3a-b040f5a91a1mr1274086366b.15.1756932891853; Wed, 03 Sep 2025
 13:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195748.226052-1-zecheng@google.com> <aLKlDp6bl9Qjiziy@google.com>
In-Reply-To: <aLKlDp6bl9Qjiziy@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Wed, 3 Sep 2025 16:54:39 -0400
X-Gm-Features: Ac12FXznFlkbSdTQajUShoNbD3chK6JOxofiRzlUCxDs4xSkJ3lGUBJ5KvdObxo
Message-ID: <CAJUgMy++zvbgcuzyQUiVHdaTZMa8o=LtSUzy9PXe_sqXHqK7nQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] perf annotate: Invalidate register states for
 unsupported instructions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:15=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Aug 25, 2025 at 07:57:48PM +0000, Zecheng Li wrote:
> > Invalidate register states when encountering unsupported instructions
> > that modify pointers, to prevent propagating incorrect pointer types.
> >
> > On x86, the 'xor' instruction may appear in a predecessor basic block
> > and zero out a register that invalidates the target register state. Thi=
s
> > sometimes relates to tagged pointers and normal programs should not
> > dereference NULL pointers, so we assume such execution paths are invali=
d
> > and do not invalidate states for 'xor' instructions.
>
> Probably we can set it to 0 with TSR_KIND_CONST.
>
It seems TSR_KIND_CONST doesn't relate to a type. Although the value
was set to 0, it still has the pointer type. I see regressions that
has this pattern

xorl    %rax, %rax
mov    %rax, (%rsp)

and sometimes

xorl    %rax, %rax
... (some branches)
mov    (%rax), %rbx

Normally NULL pointer dereference should not happen, so I assume such
execution paths are invalid.
