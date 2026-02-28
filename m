Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0E2EB5CD
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262380; cv=pass; b=f6l5yk7oT7DkzOYe73Uv6JZ3HxNZIEyZpTP8ujVEswed7elH1L+CERc0yk1IyEdPFF3KpYkkrEn9bHd5/sHkk+piTVGvGqvmnKKVb/IB+U7zOnJQieuSFq3J7kgQEDSuzy6Llz9RD1dlA0VE/HcyzNCnEJYHLgm7iV2+kSrBxpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262380; c=relaxed/simple;
	bh=OzmKA15XbZTyr5++714vwacAcsfAjCvQrdR6PuA9aN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxz1Gk7iP5rrO3AsWk3+0ltsqE5RfYJpDIXT5SPhomD68m/H62XJUpAZz+oTKMu9QBjqHcqeeBXvfoU4a2jJHeeGWHRVfTfjx8JlaDC0gID6shWQ8qt+hIslXh4lA1Lm/kt+PrQLtGEkNO5z9cuSD4hoojQuwyiD6Bo6GoIrKUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAgzwR/v; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAgzwR/v"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5069df1dea8so26556161cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:06:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772262378; cv=none;
        d=google.com; s=arc-20240605;
        b=UZFka3PWLosk0+nMzhaej6VRF26dAad14NjaVVtBl/XHwbGNJzt90BLfScfsRnO25g
         2El60XiDxsTTmV0hRJadVQTXTnK9XW0FIIaKc0DecVhN0P9bE3xbeXa9iemaFVAdqQLt
         5gJnvn6EmqY8q/I/sGyJW3K4NvoVJZcy3JuR2A0NVLu7O+nWUzekREdwhYpeA7wEzEa0
         fC0QAovW4vqWMmla7/B6FHlVdEDxpCdczXATulZxtpBXbtpy8zz4RITFIxXwNWvomb5Y
         YvS/FgNtaCnlMdTqUpwEtXrca35Bljz0Vbx7HdhPciuS+Ql7sV4nelHAXYCYR2tWuiq+
         UgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LII7NO6RHWy66M08ZE0Flb8e1/E4ktZAZNtfK4UPQH0=;
        fh=hsG7JKMSekd1fH1o0xyxRzPaYBq61XQbywFzUdsokhw=;
        b=TFL52uqgH4wpAM9yyAksu9V5NSy3eKRAMz1tN0d38ZSlY/50oGpO8BB1uahKXCie/w
         47a/hC+BbcmW6XTRJZetRp39eAVpZ/VnUCeuhCN79ViS/ZXPZsaPYRrPvVT/CGXOXRyE
         bmsXZGQ++5alzTw549aqaw1dJnH2zV2gZQ3TVJGxMMikYRxiSU5htz8A0wY5kMoWQhLA
         +pCNtdh5Fs2cOP3dPJuaZP4m54cS9nxqBcDkzF99XbDOE0XZAx2ywUNQfh2icZ8kXORc
         FGMyisatn1DuwkcqEqr6mlfoBfTKdBHD7WdIF466mOYff2V4+jELiRhnSLMw6APjFWOi
         3OBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772262378; x=1772867178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LII7NO6RHWy66M08ZE0Flb8e1/E4ktZAZNtfK4UPQH0=;
        b=KAgzwR/vF91Eja75703OkvKiig0MJf61ogNS1GZjPiANG7EAlldDrbIUOvG+cksccL
         UM+kAnkjBf5ky7QCiflwgHHO8tIrFIKvxrB2DrwHq2GtIIl2yU0ptuBCvtk5gquHfn1T
         4t9SfqpfT2bi3Q8Txw+UGhSjv5686t0qQJ1kLxDip/G+P0wItmWoPcMOD6XyghxG/R2J
         GAj8QBrIQu5P443K5WTRT9ykS1586Z5m70GH+dXRibsHTS0s7CbmPVo1mLr9rHcVokTU
         3xVNEDW4zphKIgwPpH1P13Ltzzf+iTMQmQvDuOBVTYdG5n/XTmi95ORpi7oMnk2TKRxW
         EqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262378; x=1772867178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LII7NO6RHWy66M08ZE0Flb8e1/E4ktZAZNtfK4UPQH0=;
        b=dHb14cE521FS857ODToaPzmUfOkomGwL4AI5pS+Bw4BqxI6B+Hipoh1I27MUBuAxuf
         ajWiYYaHKPd2ApQGdfjxnsD/7b1Q3fzgqu76gx7cJCtJ/zh1MLm+eyWTO23YaCjvWRTU
         KqJWBvsTks5Em55Y5/FvEB6f+aCbICMiXWwqVclOK83JWHfqs7OKqWA5ThFbngsNWxC7
         OGy8W1SksHv2UtDnnK48ftAtt439khw9rtaxymNwET8YUbYLdV3f+tu8FE1phgqg1wbX
         hSu6wMbjbz/b1VQY7AzQnz91IkK5Ms93aQv7m5Svz63EVk49A6q9XwdrgVnVKWTxAqGh
         Vatg==
X-Forwarded-Encrypted: i=1; AJvYcCXLyWtnJF282cih2cnpbJog9+M9Rz23hBJHUOXeIJZ4QeeGNpbF+m/OcHmE8bk5oyb8RJhJJWTYf/5NVoR6Ewub@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4/JnMNY2ezAhY3MB/hGXMTp5gmmw9R4PyHep7x8RglUz2Flz
	gPx/a06jHxAElADZ7toSzf3TJnVMuuUo95uowG+cXz6XEWJLmBR04t28GCE8Jpw3SNJqWvJxtvA
	wh5Bre0LwhVQUHDPlV1B6nNJYp2mjE8U=
X-Gm-Gg: ATEYQzzNcT+Yr7nXnOt8XAL7NkyzBa4MQRa30MYlaWDrTdshLpumtyI/PDCHRTkbtIh
	NAfuH8ibTNzEYX2G3jXB6dmQNFfZLhNZBNX0Tor/Iwbzplue3hKRVMnyPI57tdh/DkvmeF0KxOC
	XwciyeWftI4J9SH1SuY+vAds00usfI//6wgt+iZMTmy1RnK5lD+VauC03q86pVnqBUumaFJDu/B
	U/Udx7m5IbJPvpdKsqaJA6/urs8oAd01BVInoGEUJ4jK3rV5WynWONdHGwqr/ONtq1bJD54J1S5
	/3kS6SQ=
X-Received: by 2002:ac8:5e13:0:b0:4ee:49b8:fb81 with SMTP id
 d75a77b69052e-5075295948cmr73548901cf.61.1772262378236; Fri, 27 Feb 2026
 23:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226122208.162765-1-wangguangju@hygon.cn> <177222796929.277001.11130004024791436706.b4-ty@kernel.org>
 <CAP-5=fXep0Frpoxq=G5KJOMzmEXyrj134XsaO=p9N-61Hp99dw@mail.gmail.com>
In-Reply-To: <CAP-5=fXep0Frpoxq=G5KJOMzmEXyrj134XsaO=p9N-61Hp99dw@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 27 Feb 2026 23:06:07 -0800
X-Gm-Features: AaiRm51I_VvgtDHa-yn4Cj77vaUshlM0KB-QY_JhyH3pzwzezf7hrIxnc3pwGDY
Message-ID: <CAH0uvohLdUS6ODLZSKUA4FvjwGeqi3=9H-fJ94ybkzZPuGJ3Kg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	wangguangju@hygon.cn, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Fri, Feb 27, 2026 at 10:40=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Feb 27, 2026 at 1:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, 26 Feb 2026 20:22:08 +0800, wangguangju@hygon.cn wrote:
> > > The alloc_syscall_stats() function always returns an error pointer
> > > (ERR_PTR) on failure.
> > >
> > > So replace NULL check with IS_ERR() check after calling
> > > delete_syscall_stats() function.
> > >
> > >
> > > [...]
> > Applied to perf-tools-next, thanks!
>
> This broke the "perf trace summary" test for me (run `perf test -v`).
> The failing command under gdb shows:
> ```
> $ gdb --args perf trace -s -- true
> ...
> (gdb) r
> ...
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000555555672210 in delete_syscall_stats (syscall_stats=3D0x0) at
> builtin-trace.c:1579
> 1579            hashmap__for_each_entry(syscall_stats, pos, bkt)
> (gdb) l
> 1574            size_t bkt;
> 1575
> 1576            if (IS_ERR(syscall_stats))
> 1577                    return;
> 1578
> 1579            hashmap__for_each_entry(syscall_stats, pos, bkt)
> 1580                    zfree(&pos->pvalue);
> 1581            hashmap__free(syscall_stats);
> 1582    }
> ```
>
> As NULL is false for IS_ERR I think the correct change is:
> ```
> if (syscall_stats =3D=3D NULL || IS_ERR(syscall_stats))
> ```

I suspected the same thing but couldn't find a NULL assignment in the
code, so I rushed the review, I apologize. Yours looks good to me.

Thanks,
Howard

>
> We seem to be routinely breaking tests, which may indicate a lot of
> noise in the test output. I see many failures in the type profiling
> test due to the typedef vs struct issue.
>
> Thanks,
> Ian
>
> > Best regards,
> > Namhyung
> >
> >
>
