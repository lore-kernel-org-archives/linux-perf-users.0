Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011228;
	b=qbFq7KgsrKVBMLr2iVjSX19l1sv1/e320OYsMuEK/fQ5FEDKYZnCZfLJfL7NihnDMHHX
	 2JaR7qVibtqzio8ZkkdrwkzkCYb/xAAKmi2exsJkM/AmDOCcus0Rs1nRRqkoPLO5YVcaR
	 hP74DsiyPoz/o3eixozrH5jtG0Zj+VyH9+7h1GcFosi2mXiDcp+MbVCeiD0SrNhM62Ola
	 FJyFrPXRJYN+a3zgPkBp3prnMPOIMHmsIuOWtDbkTiQqlrThBkCUcPxCK4ioMhpfWs/dI
	 1Qh3A/gVhb4TE6ubMlzFoM2iGFHB1+u+1qYvhBK98vL4Y8jbfy80c4vBRBoqMkY4mEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RZD5CYxZCQnzKKT8r/YP482c/5NnxygRQruQyxqCszs=;
	b=Bh4b6XgfXlJ/IHCaHpikia/g+uAHPsbjtSPYcfa69RO8qiSjkJu4hLxV+1kH+WaRvbEQ
	 v7KxHsYogdHgjcXgRgi6XFNMScitOrJhKrPzUrF21STlW2shkThkQWcDWydFi3+k8HSPy
	 OBX0GCm3WZFq4o+BfLw3384lQ9ZPFAhjrHvYnQ6YXHxXNbiFqKDwDDasjlixE5HR8pFSB
	 EvYRbncRTP3udoBEz+NdO63BArtOw+LMLXqIZI82jECfJDkbtS5/TJ8OOWhsSAck4B+eL
	 94uAT04NTuNbrtGr0vrlF1XIVnQaVA7GN9jqm/2wYiYTqmu7sp7noBJfao7t0vZk5tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLwbD45A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E9606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 00:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E1E9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLwbD45A
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53cd0c8614eso8773561cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 16:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794011226; cv=none;
        d=google.com; s=arc-20260327;
        b=OBHkJHZb4lYVFTARoo7kjBbldU3rhVdSsshJ2djv4Xv/LJh9edjMxPt2ByRpI5z6Ka
         o9qer+OQlYPP/l7If0oKaSyy/zx6nXHMawGOjt5AsyG4oIF/PoFbT1jS+2EOqXdU+GzG
         U6wLsGZpxK0LqdNx0a9V8FucN41wZ7xhkc9eTjuZLyUBJuT2CEQH0VrzjVjYHHg0L+Nl
         k12uTOYaqTXBuBxP9vrqknec8BtMKkyhJ8BY0rzvIOAfnVkfemLf4iHi5qvt88qXd7w0
         GayYPbA1X8ZpZlugCker2FZ+AKZ8/jVDnGVL08gMYybvSslS68jTqMT5ND9pM93MeV3w
         tXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RZD5CYxZCQnzKKT8r/YP482c/5NnxygRQruQyxqCszs=;
        fh=tEdwsFqjqvNvxBYyD+fUzFrWB8jzWlaswrHmerpnKX4=;
        b=pnadXvgE/IwOc/jqTpa527gv4xPLvoPi/vZPrAYnSjhX/lsMWEkpfjBGe4mhoPTsLz
         UCFR/i0rI4y6RmWONo7AZ4dtBAPmvB23px1YEOEvLIAgw6uweQ+VPY9uPA1rlNAjoT71
         C1gJpqG/TGLE00UCVAR31fkmrav2OcanZ4utx5GoSS29u+cAXzc+7ygzz7cCaRy26z9w
         tZnQbT+MvVV7XM9WxGGXmWwRIp8L8XOiFughF9QXVv/RajEjIBfIScLMbgLmzMLxwWzx
         i/g56o3sKIrZoTpqMnMhXaYbUJQJWkqJDujw+arwBKjjuojEIOT/WMeYrZ8PxPL3YQkg
         cM4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794011226; x=1794616026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RZD5CYxZCQnzKKT8r/YP482c/5NnxygRQruQyxqCszs=;
        b=YLwbD45ANWkJsPa8lMr4ObPhrZseKxRrILCWAyZEPYIwknkOvX+XJevY2w9osGdDl3
         GFlnsW6X6hQvgnw+CvXtYPOtHX+aJv/mpljSqhMFj+yGF12KdsZWls4+cZuCSfD5C2XD
         75xHYnDT/lTBsOFEgts5UktQ8MuTSAA0pfvzX7m6s8dmJCJnAslsl7Jzki2y75KN9GV9
         RqHUN0yYcDso17hRp4lcwMNtjLy7liFzqqe47lVeCXSGp+U7INsOGqlJ2UhsA5Tl7kbc
         I1X7cn1QYteVMpbVWLCzapBC7CcAqHpLmmaTWZgVRu3MTEz+v49qbj1sXeKBxWiec2bJ
         0cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794011226; x=1794616026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZD5CYxZCQnzKKT8r/YP482c/5NnxygRQruQyxqCszs=;
        b=epsas8iXoGT5fRt8ln+5e1jcDDDAmO4mly+lJS4ahdxZaYOi185kD5YPuMylpaNYWa
         LZ6nQJTYTbf6maSEpS1e8EkD+u/ZRY1jnKD/PTiY47mLGbnQ8Y8FqXTCJqe9XYWh6F00
         q230YgoFiFlzQdo9tBtIdkAOjbdlIn2s0VX5sGUkPGt0tXgRhzB0EpyfGZb0K7/gBzcC
         9Jf9dzORurgrsxawvspdoDlgXgK4lGSpvn2bvdbVPY5Y3nrbvPe+2/0XBW6H8eoMeShi
         R777D+kdLpOSi3q2Fj6U/1iwT9c0umE83BzQuAOtp8gEpbKUn6JAP7/pvLg/OMiFGA3F
         Wb6w==
X-Forwarded-Encrypted: i=1; AKwUvBwtHp4+hlq4+h1029lw0mKalcVndtlrvMaLkT95/C62PTpCuA/mWlcwIHPovmDEiG2BaIbR9QiRm88d1UGZmahi@vger.kernel.org
X-Gm-Message-State: APuU4Z/3b6uIjObDEeHVXAeYbKtYg4FjRpOM0VXV5va7YbIzsLh7y3iE
	sZBGxke/gUypNmmWzWqQfGs419VGynZZOT+JBW69rs7xhTVV6/A8TklCvGcW6BwumswOqKE8n+y
	248rwbyzj6Y48WrhdJ0Kseho5Yb+j4BI=
X-Gm-Gg: AYBFou0R8X6p8aBtbJMg50VordKbi32tSaZypQLAlvaYdQ0yW+AIT8H4uAYb4ou2DNY
	U2XpzAhvZ5KiEaDmTHW/sZEqLYhh7KsvCb/e9V4JK6b5UFh523GiYglA9+nhZaodU7No2ti84yv
	ngNsvqmc+RyV/terg20hskZe7txOwSKuzADxuRzLwsdhQux4Vht+mZbo5KgrfQRB5PSbLSJhCko
	fk6NH903j0q9jojP5IM5CCPgBVBovWcBk29VIITy8OKf1hQkZhKsFmKIrjDB/lAELyR/YxqKUBj
	FxWckW/FokkY81PdEbh1rAHlqwszMRIIvwqrR0Wy8lr1FdZw5qIcLVlFSznFgO9AGOkw/pvy8CR
	3BMZSuvCRPGUosayRIv8iUE+RUR3KZPtnsD5GJcK+18H07xCz9AjR3o7Sz0MUe/sJeqzVItUAZh
	2fZD732LZAh/c7NKTHn6DkpjR5srLX3WbzRV+Ot6LjW4HX/U50Zyw+GE8=
X-Received: by 2002:a05:622a:1790:b0:535:ed1:cdbb with SMTP id
 d75a77b69052e-54e10500292mr69586751cf.1.1794011226306; Fri, 06 Nov 2026
 16:27:06 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030193237.1440673-1-thepacketgeek@gmail.com> <au18AJ94dUsE5PaQ@google.com>
In-Reply-To: <au18AJ94dUsE5PaQ@google.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Fri, 6 Nov 2026 16:26:54 -0800
X-Gm-Features: AclHuK_6N4pFWbDGZNFsXaX8wHmLg6IQTzl-OftZZtLJdtmw1P5hJarvleMvIB0
Message-ID: <CADvopvYeG74khivCbBR=LsFNAuqDzn94Wg+LA4PwscsQue510A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] perf unwind: Don't load symbols when the caller
 doesn't need them
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 11:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Fri, Oct 30, 2026 at 12:32:32PM -0700, Matthew Wood wrote:
> > When perf only needs to know which DSOs a callchain passes through (as
> > build-id marking does at the end of 'perf record' and in 'perf inject
> > -b') it resolves the callchain without symbols. The DWARF unwinders
> > ignore that and look up the symbol of every frame anyway, which loads
> > and demangles the whole symbol table of each DSO they visit.
> >
> > On arm64 every frame pointer sample also gets a short DWARF
> > unwind to find the leaf function's caller; since v6.17 (commit
> > 29be60c93d2d, "perf build-id: Mark DSO in sample callchains") the end o=
f
> > 'perf record -a --call-graph fp' loads the symbols of every user binary
> > it sampled. On a 128-CPU arm64 host,
> >
> >   perf record -a -e cycles:u --call-graph fp -- sleep 2
> >
> > never finishes writing perf.data, with over 1GB of heap growth in 5
> > seconds.
> >
> > Skipping the symbol lookup isn't enough because loading the
> > symbols also finds two things the unwinders depend on: the DSO's
> > build-id, which libdw needs to fall back to the build-id cache, and any
> > separate debuginfo file, through dso__symsrc_filename(), which is how
> > both unwinders find a .debug_frame there.
> >
> >   1: add dso__load_symsrc(), which does the same search for debuginfo
> >      and the build-id as symbol loading, but doesn't read any symbols
> >   2: pass the symbols flag down to the unwinders and honour it, using
> >      dso__load_symsrc() when symbols aren't wanted, which also makes
> >      the arm64 leaf frame caller unwind skip symbols
>
> Please don't.  I've added dso__dbginfo_type() to handle debug files and
> that's the correct way to get the file.  Probably dso__debuginfo() would
> work for you.
>
> I was working on cleaning up this area, but sidetracked by other things.
> I hope to find time for it soon but you can go with the above helpers.
>
> Thanks,
> Namhyung
>

Hi Namhyung, thanks for the feedback. I'll look into those helpers and see =
about
using them instead.

Can you confirm if the premise of the issue I'm reporting and trying
to fix seems
valid? Would saving this unnecessary work of symbol lookup when they're
unused be part of your cleanup?

Regards,
Mat
