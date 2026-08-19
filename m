Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FE22083
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787113008; cv=pass; b=uwCbqeomplv+Gr3L0frCa/O6FbRegGSZCyB/zQphFp5s1roHv3l7Qgeaob7LyqbGcZXXY0Whky3E7EAYDzdzvjpulfStXNohcAG5uPSEf7iTWY7SeJd7Naf7BnXp4+q5D1cj6p1HrkuQlp4LnwEPQo97lgkrc5coF1vq02NVC2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787113008; c=relaxed/simple;
	bh=nNCO/RnzImKIQbbh4Dy0dbwXvbg9ERPf6qACYsdxwzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDYmxoHv9tKVGyMGt+/x8uNJoAx2h7mnCABdW7+e+nNdJ/uyP7M7WEsyCS6l6Jf5Z4SHq5i4MBXF3Ws2EjSS+HV0AWS+a0O+LnvKgKYRfiSgdWaeFFc5YqwRiERZiM8D68A6g1nHM5a8JC/hD2rdyFXNnb5bmK4BDKTjiSfzMmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SI8XrPeU; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SI8XrPeU"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c15a5b265so129951cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 21:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787113006; cv=none;
        d=google.com; s=arc-20260327;
        b=eu0S6WEKn4a8IG7JxZufOIEFMPdsV6VgawCR9vC9GSS5xuAqHaVttLJW6a9Pmamutv
         hk52dsTGszagoPm1PbTWuY3HpQMZs3LHd5L8Rg/bSPkDeI1MddNO6pAnov6KZl8YDqST
         zHld/L+XO2ewrq1ARTb75dHFIXHt38p4Y22PiDafXXrz1x/GmF7hJl058EDhtIv5T6Ic
         HKhoVzKNclx2DJWEj+1ox0j4pZw6w3NEcAPByzmzYMt5ElJdDDvY6keRuloKc+PAVBRl
         lpMaXeysRLTH6COe1/JFhgD1t0AoRpRNOf3W5+4o1tyu5SV45CJYH82eEl5ZIBflsp0Q
         kXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAKKouoUBeuvxqVoZyLbYA3g6AB5nMN9wGalOwQu9WY=;
        fh=zcrbJdCPhhqjm1PsSrqFC6J/gNAxrAE+pNthBSBDBcw=;
        b=BrrPZjtKPqiEl09DpqPPDjaCdpBSOUDVqtwvCJgyvXtlu7d9Nto7sAuOI2cieBBi8a
         gxNszF7a2R5LqVhix3dKuf1se0GJSb0ZJxhlABkDkcqHcdtwD/Y1RBgQQCbSmSbKfXSe
         HSc/HTBFeIc56MGDQu9bB1zlhejbSApSAyokrLH5wajnJVrgKWX5a1+yIknJYlDEQQDa
         kpvec3c5fJxq/2t+/ntR59tdO0sXd2UDVYT5fRzWbfAfSB2REFa9v1UhPskalqurt45q
         q/jSKoU5hWGPvAYYpx7rvkr0lXh3plY3QDPgBnAC6gfG7+FFH83WXpE5tS24KYmiEhYO
         qHUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787113006; x=1787717806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UAKKouoUBeuvxqVoZyLbYA3g6AB5nMN9wGalOwQu9WY=;
        b=SI8XrPeUOoxjb7TGZmNYnDN05QSif5jXZlNEdYMlKhxY5L+92vJiH+9yeoE3V6r9RS
         VsWRldMd/43MMsSTgOn3XGSJOIPAMkoMFCakdDl1XUw/Ctak9bHmD7fhIA284Q9guAlc
         YfhOyNsXgtlzZ6KLBtP4FSaF346DoCs3eLZXCKb7HWV7taDUlPJETiTMObUDU/e2S/hs
         RH9Y9RpZ6l2H/AsqACcwkF5eVtGkhY4EB99iIKilKwu5VXWjOHPPIfeJMWEi+9aYToQt
         pGkXy7Vgeui/k22FHuwl+89wIDse0mJNlbOfqYgRS7THQXOMDEGbmrEwWeRJT6nOOIQH
         KE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787113006; x=1787717806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAKKouoUBeuvxqVoZyLbYA3g6AB5nMN9wGalOwQu9WY=;
        b=ltwp4QkVrjzKU44nQsksfCJgLCECOdKmM8w31YPqJGCBxRzfrQAf89FWxSIr3MbmQD
         IaO2wEs1okICrLbpLd2eXzuUIzxPwCv6oECa/Nfqup6mkQYGniU4o4fenFTYRDpPj4Id
         LqYQZ6ZblQedoPp2s6KRdCPeadqcmz3mA0DgeNsABd0maZUWBM+4yqRyG3rOexD1+t01
         ZvrtCa468PcEWY6fqzXPWhdkY9fXoh38HuxmSaLdS0fEBq1J5uL32SGVmlmmQLxwFTqV
         i5kQzHHktTrbzlfRqMl/UWXWpaNg0MtMKQNZ8tcsH0965HFlKnB3w3JH2dWOZJL1Tmmj
         NHqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqk+z7gXv2lyPulaExdKxEb1uQyDwr4UrBqafF5QQpuTtsdhkcFIdaeuIKKTKcBR0fLCUgGX5aSSwtJbBODna7y@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgGV+mO1Yz74SQpwowE6ygQ39PKjn+vx6KmDr8ZdNrERRPwS1
	VuLM0O5CLDL6nUYRE4M/+BG435vTOJGnrKPcKu0kb/l5L1IoV7d12ILZv7Qlg6tg2me2E6Y0OpY
	KBeEaE3uXsDgcFLq1deGsmZM3QO9XT+JeRJvBk1Lx
X-Gm-Gg: AR+sD10d9THMiB2P1sXtGOEg3+/mF7epPQB53uNmG/JBKgUp2KHQoPoLS1K1ebTD7d4
	lbVrEzmrmSblG3JY29Wq/ByLwbQoOrmLil1GXzxv8cqGBHzBtfYmzKGoUKV18MR+p0axH+3NVUW
	0o5YTfYLG6KLEKbvIEG8b8Pz2e5l+Ahb6YKSyEaWpUMVzKYkPMBM4B8M12TlqsTPsCjeBX5sQOT
	n6LdJmbijvq+Fv9RyBBXVQVk7jtyvLx3F8j0DAo0O3QSfwHQYFx0Dty+GLeoC23odoV0aVcsTWN
	G24DvIQDKmUiK5gtEO7DFSPP+sO5PqbtPoh7JvL2SZ0+zw==
X-Received: by 2002:ac8:5a81:0:b0:519:b655:235 with SMTP id
 d75a77b69052e-52dd909dd1bmr2783011cf.3.1787113002202; Tue, 18 Aug 2026
 21:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
 <aoSWkMjxuz3hYr7C@tassilo> <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
 <7f5ae51dea8c7b6770716dedc46ee1b3@firstfloor.org>
In-Reply-To: <7f5ae51dea8c7b6770716dedc46ee1b3@firstfloor.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Aug 2026 21:16:30 -0700
X-Gm-Features: AcwNN1Ws9LEvadRcPcpLXEW_fXytqUrds9tZN-uCjmJBrPsotHLMRHKJTtxIHGo
Message-ID: <CAP-5=fXLe9tqR7wHh9auRxqX82Fw6zYh1EoTOXjPhOXcRXB92A@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
To: Andi Kleen <andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>, namhyung@kernel.org, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 8:34=E2=80=AFPM Andi Kleen <andi@firstfloor.org> wr=
ote:
>
> On 2026-08-18 19:58, Ian Rogers wrote:
>
> > Since we have frequency mode on events and the periods are aggregated,
> > I find it hard to fully think about the ramifications. Consider this
> > example: I have two identical loops, one loop runs on a p-core and the
> > other on an e-core, both accessing identical data that fits in the L1
> > cache. Since the IPC on the e-core is lower, the number of cycles it
> > spends in its loop should be higher. A user might mistakenly conclude
> > from the higher cycle count in one loop that cache/memory issues exist
> > in the e-core's loop, rather than realizing a scheduler issue caused
> > that loop to run on an e-core. If we detect a hybrid system we could
> > switch the default event to for all perf tools to instructions, as
> > instructions don't suffer from this problem.
>
> You already have this problem in any other system from the last 20 years
> or
> so which has frequency scaling. There is nothing special here about
> hybrid.

With frequency scaling, doesn't IPC remain relatively constant with
frequency when ignoring external factors like memory? The IPC on an
e-core is expected to be lower than on a p-core.

> The scheduler has some internal magic to handle problems like this, but
> it's probably not directly applicable to user presented views.
>
> In perf there is also frequency mode (which is usually used with top)
> which
> kind of mitigates it anyways because it evens out the number of samples
> (at the cost of some terrible statistical properties, but that's a
> different chapter)
>
> Also in general people don't look at cycle counts, they look at
> percentages
> which scale per CPU.

So I was in a presentation today where someone claimed that larger
cycle counts translated to memory system overhead, but they could be
unique :-) In my two loop example the lower IPC core's loop would show
a greater number of cycles than the higher-IPC core's loop. This would
make it appear higher in `perf top`, leading the user to drill into it
assuming more time was spent there due to issues with the code. As I'm
hypothesizing the code is identical then the higher `perf top` is down
to being scheduled on the e-core and its lower IPC. Having identical
code where by default in perf one appears worse than the other doesn't
strike me as desirable as the same behavior wouldn't happen on a
non-hybrid system.

> > How can we merge non-legacy events? On ARM there is no PMU with a type
> > number file with TYPE_HARDWARE.
>
> Very few people use top with anything other than cycles, so it's
> probably
> not a very urgent problem.  I suppose you could push the problem to
> the user with some configuration file.

So I think users (and me) don't like the choose your event thing at
the beginning of `perf top`. I think the work in the histogram code to
combine hybrid events is valuable. I feel that cycle counts are open
to misinterpretation, so instructions should be used to avoid this.
Maybe we should just ask the user to select between merged, cpu_core
or cpu_atom at perf top startup, then misattributing cycles aggregated
on different cores was their selection. Maybe we should just warn
about cycle aggregation on hybrid in tips.txt:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Documentation/tips.txt

Thanks,
Ian

> -Andi
