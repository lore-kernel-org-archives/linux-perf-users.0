Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792706426;
	b=5Dn5UzXmMMGljVJYOvKWDUHA6PvoNJLEw/mzFx+GwcI2AO9Hgxm6pYFAh+TefQyjhXOU
	 +RPeL7dv/Pzsa6Jz0PZmD3Vaoy9e0m/1hRNFaKqooqGzP+LIDvDg42thVIroLe3T4MxFT
	 eZt7xiNS9MUu6FvQK87tQGfSO4i5597gqUXWnNX4EEW4ic3oMV4+Nncdx27MbeY/kqcpo
	 Glctc+XQBjKwT7Un2lfxu9vfrRR7O/Xta0HR2lvIPizMHii7S5yisPrVUzdJwupsKa/iP
	 ZLgh98ncGua5CMZPz00wtoW+tYDCyyitkNWweuVbqnXCDajcy8HIy90dGyh37CQ19/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c94QHvwHA9KD9Y8TkxYNf+bUuPh7FSzG/6gSPDecY5I=;
	b=H8bIMYtoIZWWxo6Cdn1LJyuqwZBx4imtKWM9+7ww/SidLSN2T+ImVyCm948PBd9YVjtB
	 j2ZzVaJLF0OsaJoO5dsSywMxxhn+67qhmOmYp6ZLaZ8AzYnRyGE/PKtfb1XEo8RjIaI82
	 JyV9+JGzX2JBcf2lBw7wDzFKPKfRgh1ronTyAdCnLxvv+ygoyJ4S73rQ1Ynh2oECaylG/
	 WFlPx21e60iZUv7M+LYwjWChoBSGK+LOv2i9G9vacfFRwzti7OhbFPKWOHXITD9JhtQ3v
	 ZXgFhgD698FuM3vY7z6QbUlKI9Q98jN28fSf1DS0wuYgHCjO/XF6DE24laHz9avo1JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Y6giGUFz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AF606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 175AF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Y6giGUFz
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5337fa12431so43121cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 15:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792706425; cv=none;
        d=google.com; s=arc-20260327;
        b=XEh7zIZQfKpfec8BZ3HLiIoaxvANLD4Jbmb9Ceycfzfksb09JbpcOQ2garhraLG93d
         LsqdPk+niYQGE23/6i+bh26k2q5i1MWuhh26/YBfjKrmSxsSuWx9Lt/f8NWGCoYnS2t8
         CsIbz32hn+v5ltxeEfF81xdKGyuhY+J5iY1fM+sdXgKJt+tkqRhj74kRq1ed6HnzMGLA
         aiyiYEdRyO3ElQNnC/fd3SBeyLA2AOdTWTWrjP6SRvWeK2VscDCgeqWZWgNEVmoq9+TB
         pC/WsMjpTGd4wI+0oESxuQRBdk1fnIJDOnEz8OdABDv4JTVw3QfmxG19Z+yZj639XxRm
         TXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c94QHvwHA9KD9Y8TkxYNf+bUuPh7FSzG/6gSPDecY5I=;
        fh=VkenyqwWDw5tzxfw27xbiKz9XnVZSSpNIBRaf+9dRZk=;
        b=LQBkxUg3r5dqKVgIFaq+4Tdy7AsEiuhYfuWk+mRk9N+/d1TfqrpyF2+zkBtvw9YKgQ
         syTf70ChlotcSbz7yb9SVMDo9ywZyFyXb20a9a4n/4tS5He9LGXHwKWMTci0Ogwevo6L
         46Cd54QzdkqWEikHtkNEb+F8y52QdUGO3i3e+wER5qybTbKkq1HR8PpALdB9ZpBBc5kW
         a6+vMKA4bP3yVqtWPCGf3SFOb+m/LzrZeKKaYUDIAQDteOCdnrkdX5VkhgV6zDMUkiEd
         /NjzguWmkhCAtqxCNy4FiOGDXM66ZKxlCptfkWCJXYBmhE9aol4Sr253cTbSSRzAAhRU
         0oGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792706425; x=1793311225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c94QHvwHA9KD9Y8TkxYNf+bUuPh7FSzG/6gSPDecY5I=;
        b=Y6giGUFzRakvS/93R+Km1cieHI3o+VpNcs5iGCtw2fNSIESS1bUFEypZeUs4/npocN
         vgIP0oXsz41fffHfL3JLPhYnt2apeOXvoZH7cFlJ6mEk724MuoGkn9+xAVni0a2ZaDJD
         3VWYhes8oQAvIKbF7WO26YW1WJd5ACLXJGdBSdV1CxzjwBqTPqN0rl7N2ZHThIucO3TB
         z94wP+MazDeoBnshDkBZNmDpKwBdGfaWOWZa7mvc3PA3kOj4bIltRspjHDKcsEtkEqEN
         swyvvW/UHU7+i4Xgs0pwEYrdx+pfxgE2zqgH0JIByfWtw4S/YpazeA3Bbb+0dVnVyrOJ
         lDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792706425; x=1793311225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c94QHvwHA9KD9Y8TkxYNf+bUuPh7FSzG/6gSPDecY5I=;
        b=E0L83Ehl88a7y6DGvj4WTJ7Ln6nkQcT9ya6Yf9nc5JbTSxYji6kaGzmY+gBFEfe2Xe
         gxPG+2m9sY/eKHF4zqjl+4Jcf3/p9ygQsBsQIpnAF7rVYouL1M1frBkb2c7tftJADoxi
         Dbw4vU01Eg5vXg7eZPC8swmUeG/OcMfQ0JjBYUMOBSxUMDuFtEsWvIlvAkw8df8ntoUW
         9dDb2NTM8UrlQTwwO7nDRKlbkdaN8cQe88c87TWTC3NLgHm6w2t5O2Q7rEoDrOucaZ42
         hKeIASe2ckjKHzsGDNVydQs6U4v2vjo7yJVhZvYNYBGDZ07LSRSHHhxYF3wyxPbXELqi
         ABlg==
X-Forwarded-Encrypted: i=1; AKwUvBxwijQDIoUYlaoVNBv0qZWPGGqQ7IEjTaFRyVtKFNnGTDaz6I7UaM/3eqgfB2SqFJLi28jQfapVxZdKV1vvBUvC@vger.kernel.org
X-Gm-Message-State: AFq9FYJJqNT20GwypPSLgFKjHRSQPzDhp3RccI+HLjgPGK/4LlSZKZqt
	C269P3WXbYQswVyiBlD1xaHNA2ozG7ZQXJ6ZxOxU7YS8WJnAFAC2fH51WsOE8hRuSINN10gWtpx
	vPV/lLh4mHB6cPhYu8vmoc7hKxvJUStMD0ppk9oy1
X-Gm-Gg: AYBFou2biAxc/VIdsyfJ/5oP8FSjuJQYgD+V6GZnn5Gv1L+rkcBVyeBPBVBpkO4FvLo
	Lx9Vx+lxqgWwTbUWUU95OTEMg7Kii+pXlusW26rKgHrUt3flDwVyODVIUnozL298dqz6K+Y9G+S
	QKgwW0GWBMD6Hu/jn9d5Mzo5eHBb+atyFQpEljIuDYGhfdb4CIg7anjS68C3dtd+zG2WOueFhMH
	nrEePod7zIxe/tV3A2LnW3X4Shjj/Y2PbkA+T9MXNuHmWa/B+42mVFSTzb27VC7JezzcfsMQvZT
	QverGnfp/OSYLHhnlUQccj5rj1xrfuLZbmGyYGJC2KTqM73QRsPwl9lSrb0B0AwGGeb1krqcQ75
	mdmFYceDgilT78JrL1EyNi7VDcPYklRcdJMg4aaATo8RrmLrEzVYx0pCqvrFs7wQ5KPM=
X-Received: by 2002:a05:622a:4d94:b0:532:a17b:9581 with SMTP id
 d75a77b69052e-536c26e227bmr1882291cf.3.1792706424280; Thu, 22 Oct 2026
 15:00:24 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022182431.25673-1-acme@kernel.org>
In-Reply-To: <20261022182431.25673-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Oct 2026 15:00:12 -0700
X-Gm-Features: AclHuK97vkvRJzc7cmEXsXtiGmaNzPIcpiuUo_O5efyyeodZ05JZOkzDOeriaF8
Message-ID: <CAP-5=fXL1-shL3TH8Ug_E+8mcnpdkEy-xU0UPXoZ8_DmLZrCLw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] perf tools: Add a script to sync the header
 copies with the kernel sources
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-perf-users@vger.kernel.org, 
	Amit Machhiwal <amachhiw@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
	Christian Brauner <brauner@kernel.org>, Congkai Tan <congkai@amazon.com>, 
	Ewan Hai-oc <ewanhai-oc@zhaoxin.com>, Hemanth Selam <hemanth.selam@gmail.com>, 
	Kir Kolyshkin <kolyshkin@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, 
	Yuyang Huang <sigefriedhyy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:24=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi,
>
> The tools/ tree carries copies of kernel headers that are refreshed by
> hand: check-headers points at the stale ones, then one looks up the
> kernel commits that changed each of them, pastes the relevant bits into
> the commit message, regenerates the beauty string tables, builds the
> consumers and commits, one header at a time.
>
> This adds tools/perf/scripts/sync-headers.sh, also available as 'make -C
> tools/perf sync-headers', and patches 2-10 are what it produced for this
> branch: for each stale header it finds the kernel commits since the last
> sync, copies the file, runs the beauty scripts before and after for the
> beauty copies, builds perf and the other consumers of the header and
> creates a commit in the usual format, grouping the headers that share a
> consumer, as with the KVM ones.

Initially I thought just doing a build was a good proxy for this, but
that wouldn't capture the cross-architecture checking, so nice!

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> The kernel is the source of truth, but a sync is skipped when only the
> tools/ copy changed or when the copy carries intentional edits, and when
> both sides have content the other lacks it stops for a manual look (as
> with gfp_types.h and msr-index.h, left out of this series for manual
> handling); '--force' can then sync and record in the commit the tools/
> additions that are dropped.
>
> As for the state of the copies, only two headers are newer in this branch
> than in the kernel sources, perf_event.h and perf_regs.h: changes to them
> go to tools/ first, with the kernel picking them up later, so the script
> sees that only the tools/ copy changed since the last sync and leaves
> those alone.
>
> Best regards,
>
> - Arnaldo
>
> What changed from v2 (593c116cb5ff1ea4):
>
>   - 10 patches: the gfp_types.h and msr-index.h syncs are left out for a
>     manual investigation.
>   - A tools/ copy ahead of the kernel is left alone; a copy that diverged
>     stops for a manual look, --force lists the tools/ lines it drops (sas=
hiko).
>   - Copies with intentional edits are not synced: their kernel commits an=
d
>     Cc list are printed for a manual sync (sashiko).
>   - Beauty scripts taking an output file are run with a temp file, and th=
e
>     script/header mapping comes from the Build files (sashiko).
>   - Merges that brought content of their own since the last sync are
>     credited, e.g. a capability renumbered to avoid clashing with another=
.
>   - PATCH 04/10, 05/10 and 09/10 have new subjects; 05/10 keeps Mahe
>     Tardy's Acked-by.
>
> What changed from v1 (e038fb24a0925576):
>
>   - PATCH 05/10 (was 07/12) carries Mahe Tardy's Acked-by, no code change=
.
>   - v1 was posted with only the files matching '000*.patch', which stops =
at
>     0009, so 10/12 to 12/12 were never sent.
>
> Arnaldo Carvalho de Melo (10):
>   perf tools: Add script and make target to sync the header copies with
>     the kernel
>   tools headers UAPI: Sync linux/if_addr.h with the kernel sources
>   tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
>   tools arch x86: Sync the cpufeatures.h copy with the kernel sources
>   tools headers: Sync linux/socket.h with the kernel sources
>   tools headers: Sync UAPI linux/fcntl.h with the kernel sources
>   tools headers: Sync UAPI linux/fs.h with the kernel sources
>   tools headers: Sync UAPI linux/mount.h with the kernel sources
>   tools headers: Sync UAPI sound/asound.h with the kernel sources
>   tools headers: Sync KVM headers with the kernel sources
>
>  tools/arch/arm64/include/uapi/asm/kvm.h            |    1 +
>  tools/arch/powerpc/include/uapi/asm/kvm.h          |   18 +
>  tools/arch/x86/include/asm/cpufeatures.h           |   15 +
>  tools/include/uapi/linux/if_addr.h                 |    1 +
>  tools/include/uapi/linux/kvm.h                     |    4 +
>  tools/include/uapi/linux/rtnetlink.h               |   25 +
>  tools/perf/Makefile                                |    5 +-
>  tools/perf/Makefile.perf                           |    3 +
>  tools/perf/scripts/sync-headers.sh                 | 1676 ++++++++++++++=
++++++
>  tools/perf/trace/beauty/include/linux/socket.h     |   11 +-
>  tools/perf/trace/beauty/include/uapi/linux/fcntl.h |    1 +
>  tools/perf/trace/beauty/include/uapi/linux/fs.h    |    1 +
>  tools/perf/trace/beauty/include/uapi/linux/mount.h |    1 +
>  .../perf/trace/beauty/include/uapi/sound/asound.h  |  200 +--
>  14 files changed, 1867 insertions(+), 95 deletions(-)
>  create mode 100755 tools/perf/scripts/sync-headers.sh
>
> base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> v2-head: 593c116cb5ff1ea4
> v1-head: e038fb24a0925576ac82b065f32b3c72bebe4b62
