Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB032877FE
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161523; cv=pass; b=hXwrpVkvw2O1L36WmMI3/O5HcclO1m0byP0WuNvk50ChKbR5QiUMMgjpnNWlu0xPA0HeDnSI+fv7xzEiGqvj8vsqxw7Wb5fZdVY19YIx78zbDP7CDrPiMJtEFZ56Egk0t5wmdft03xPbIyY4fdE9CwBHW2ZXX2YTDwpoFnu4hMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161523; c=relaxed/simple;
	bh=SzHbdy/znQ7czKD0Ua0EXloLpgHVFFpFGTjIrwwCd0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLzw6g5hs0fi7tLRHaNtMR8jdhG9s88P1rtuO72bgok65LSR2Gcqqtp26QH3lYgR88k2jeaLm4snwgCXunRppC4HE4OY9l0x65nuB/HFkcBueQW+gEABO/EK/GTNiPR0uhgmkizf/Ak7khkYhHW4K4iLlsk2q92FS4carLo0LV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1fVWmA8+; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1fVWmA8+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a76b39587aso16495ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 15:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770161522; cv=none;
        d=google.com; s=arc-20240605;
        b=D+P5TSjsJOUjwkXLhOZVvECRpYCS5WNbPqZXgnuOs+EuMKDNAAhGafVcvuh2iEnLE/
         cTtzwAyLRCxFGerSg16ZNpSLbK+K9ix533Wek5d9qKU0N+CGPAq0LHAM4bYv+xfGMPMU
         KqG7ltUk3b4OI33wOJejAFEmNDj9Mh6fw+sM5y7jGUPH9YhH4dJBTAgCf7b26psnm4uo
         GXkClk/s1DzZicWkic9uPun3unH51NVnkJNru9HyapnfA6VF42jJlmu+0+KiCCEihA01
         cWJrK/0wut5FTJNUqsx4E+at1/sw1yUeRCXAuoOZnW9p0hG8muQh1Ysf8l7KmhVib6Yu
         Qy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AXL1CUqH579Sg/oIa3T7wXb4Zqbf1kJm1J81+XCJrZ4=;
        fh=1gssEPBYQafJ+pEYKjrr7vfcIxaiDnQ1cxvXKeIQus8=;
        b=UWN2BJgnjsUdYM8Jd4Jp+jdceYj7JQA7Pba7j5airyEydiOVjWB/oD2KoEPqajjLiL
         d5x5cYKdFCWZpwHu7BebVK6ndtTEG0q7MoXOtERpbNZwA624zMJ//P7IcJwEEXNvhWxd
         BuGLcCVlRQOPNZ96znhD4+yO0Zql6fajiXPo5puS7GgAXPaGiulnUdj3aXHhZiDew8Ia
         fU3XO4eJtHRiOtxO/qyY0b4RDxH4DXsAJSxPTXrIDApFFhcQ9JwqWiIM0Fiznb6sZ8pp
         ObyT+BZ36HVm9DvrasTC2q7m1V7x/xpRHb5bswdhMWbod/684INJy/FkDk60Lr+i9iQ9
         qUxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770161522; x=1770766322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXL1CUqH579Sg/oIa3T7wXb4Zqbf1kJm1J81+XCJrZ4=;
        b=1fVWmA8+oPVtoyqGt+n+li/0STRM3ADQ/4s5IKkRR24XpMj44rX6a8gUnFCXO6mi25
         8XHvbhdGiMOCapxCjy9pI6TLqKvFp62FFWTChPn5ZAeo1Hqkyjpes9c0DHmXKJ5fvaTE
         PgkI3nkyO8Hb+vexki1oYogjanC3X87GLuJmQTpds7SVbrepewqGfLMYp+YuJoqLB0T8
         K0ypqkEYzQEEjpY25RE6BiCamXKU9934k1abpkU+3HDQu9SlCHXvubQAxUzjW0sosKcJ
         2U0N7Fzx0Vz57u8ukxFFrefVAHiZqSkWrCAqH4/QnvdVQNuZUEASwmhKyELZMkJOks0L
         7m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770161522; x=1770766322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AXL1CUqH579Sg/oIa3T7wXb4Zqbf1kJm1J81+XCJrZ4=;
        b=VoMRWB7xE/JjobqtANQuvjfGMlqXx1TmBi954Hc+ObmG/Ow4I+xpMKvoLfbKEV0c8j
         9YRc/8dndsTZXXuCPQTKzmw/nlLCwqhjdr6WWqjTVrt+dButfi1rYnQ17cg/sVVg2taw
         iTp2qu/66Aig2dgDb/BZt+0wGLMwBbfC00pgitKvuGq+Qv9zZRJkeDUuFj379buq2q1n
         0eDOzE7gtye3A/tZO0RLwi9PL24eLzR/3BIGR8wZKI5qYSLSefsgNsnEC5IaGT5wlBfB
         LEFnSBX7g9Iw9wE8ctEpsgYiwiioh57DizXA3+XapTSDoi7T3lBxfrqJ6yGYNwzL8aS/
         nlSw==
X-Forwarded-Encrypted: i=1; AJvYcCW4MsXwNr5hzm1xRj82qKvVf9a41U0/QMzalqQHDRVUotxm2A7gQiYm89OxBh6X8XtCx8BjvYPP2KM9VxQ445jj@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZSF3HKdMwbWGiUVO6V+86TdOf2QlYNu7qfTgHnVvV+h0z/Jb
	+pXmxo3NPWtTmD6pATgdfBajNLigmGVAJq+rZopIJwqz4GhX6BiSiCh19Ml27IMvHrrs2yVZy5G
	xSZ2fXYMJ6yeCD6BnFwLPa5t10w32wVvVSUoP/Lyk
X-Gm-Gg: AZuq6aId45gpOZQO6jnxuGmE5uU+i70zj9G+MGxEbhkgWYl/crd5dWLMBVJHZ56h+L3
	0+a7drPajjwRv4R58kkpaKH50Bmo5UuKN3SqnKKZng4ZzvbedOVEeDywiwOqc/S5PD3b6nsStvv
	5SX6xihFRBP73SzxbBjTaGORuuhJRaeL3lKGCsP9gqXf/iA2d/PA8dqm+ps/MhgO02hJovYsbcq
	XikGqKFsnUUOJff/CPl8kCBIhAUyjo8XpkK+RhRQexXWFlsIDvsHdpLhRbomjmISoXbYQjy0j9t
	++mF9MWJKrENaEdhkxsEottSQ5DGHJAeJfM3
X-Received: by 2002:a17:902:d4d2:b0:2a7:9532:1a2b with SMTP id
 d9443c01a7336-2a934560038mr1190855ad.20.1770161521331; Tue, 03 Feb 2026
 15:32:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com> <20251113180517.44096-8-irogers@google.com>
 <cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6>
 <CAP-5=fVk+B815c3CX4BLSR++JQPX7AgVnO-3Ef+=rj2DLVRKQw@mail.gmail.com> <thuc2tb6vdrm2fbvcezmm6xqsvyjsy7rdafrcbksk73om364xc@sr4yd37i63go>
In-Reply-To: <thuc2tb6vdrm2fbvcezmm6xqsvyjsy7rdafrcbksk73om364xc@sr4yd37i63go>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 15:31:49 -0800
X-Gm-Features: AZwV_QiLHxaipqXMna4PtA4jNEeNuzKers-plPN9CGq7nRLUK21stTYOP9FIs6k
Message-ID: <CAP-5=fVQqfKwij1GV56136bY9xNVz_tveKQWFCS5o7eP7W8bUw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] perf tool_pmu: More accurately set the cpus for
 tool events
To: Andres Freund <andres@anarazel.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:27=E2=80=AFPM Andres Freund <andres@anarazel.de> w=
rote:
>
> Hi,
>
> On 2026-02-03 15:05:39 -0800, Ian Rogers wrote:
> > Thanks for the bug report! There were changes in v6.19 to change how
> > metrics were computed hence the fault in the metric computation. The
> > bisected patch is at fault, it aims to compute the CPU maps for tool
> > events in a way to avoid unnecessary sched setaffinity calls. By
> > having a smaller CPU map it set up a situation with user CPUs where
> > the tool events could have no CPUs, removed from the list of events
> > and the later seg fault occurred.
>
> Thanks for the quick reply!
>
> > I sent out a new patch series:
> > https://lore.kernel.org/linux-perf-users/20260203225129.4077140-1-iroge=
rs@google.com/
> > that has a revert of this patch, a fix to correctly avoid the segfault =
in
> > the prepare_metric function, and a new patch to properly reduce the CPU=
 maps
> > of the tool events. The remaining affinity reduction patches are still =
part
> > of the series and I believe ready to land.
>
> That sounds like it's targeted for 6.20?  I assume the revert on its own =
needs
> to land in 6.19 (or stable if too late for 6.19) somehow?

Yeah, the maintainers are the ones creating the pull requests and can do th=
is.

Thanks,
Ian

> Greetings,
>
> Andres Freund
