Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252503B1B3
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786162436; cv=pass; b=jyK29cKtjxkA2WRSzAMTgt05RAQQvSMncFrbNaQOJ/XN5R7UNEG+W3b/alHOqDOBj+ZNrbkYTIF1P9Moj5gf/CVoRQi1mLrrvrpN+mSLnJupYQrnnw2mqQvjHukWu6xuw7s0tjqEKeg0LktSjQXMp61oAl+Cl4vimXFqT/iwMso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786162436; c=relaxed/simple;
	bh=aitTYh0qnUbeJYOzgNmzBLyVNMmg1720VEJ6UqV5Rb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rce0FKnhnrlcZtuO+jgCHwwGW6nVvF+SyEMWGEd9mR0KrdS6p5XK9W/tjbBORXzeqEUlOn4JlJdFZS0Crh64jj5Dr4Ohg1YKFbi6XjFYto9Wvi0uKX0fO8airVuT7rJZ8LQtDBMC/AxOFZRr9YZP++/3xrDa0Es+e0oOizvzfpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5Kzoowh; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5Kzoowh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10e86e52so71371cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 21:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786162434; cv=none;
        d=google.com; s=arc-20260327;
        b=ExwerZuIcC/W1w51Ghs98hVxELoJHJ9sJISjROJclrkpkqhwU++LDc53CyHrO9frt9
         7gx1wryah/VHNXkZs5psk1zJ3g2P7JfsUrjsT7T7xV5Z43pXmjnNLApW1KntKpEICKYU
         f2kiR0Y7dL+eTSFxEM1Svo099BXhRcJiDVecS9BKUv7QO/WWVZfo1GnQlJlu5fq6rf80
         V+xf2ZB2fPo0IDIJLU0RsxMR0DiszTOOKyYNUT/dxs4TI+yD3W+5ylVVnnOPIam+EukF
         CpIa3yAQFoC5Tyzl/xypTTdV8WBxt+ObQ6b2FBkbwtFdqIsn32zpz5ihsskb71ikCzCd
         aKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G4UK+N1D7eZ3gh+QYJXokrWxjuw5VKrcGy+f6JcSXuM=;
        fh=Dq2KHGDAIy3Y7QGrSTpsnMk7zCsrTArwRjwrsRlhf88=;
        b=QU66UEvomJaaX8yCBwpzEo9Q2MezWdTI8JTeNGH+LUad12yj+GpXe08g2iwXyxVuo+
         WT+uA/fTrC+ytMtrTVbruZU0DEmC+gTU30YZ6nEp46Z5l9R3uwqlbPBYfIk4IlLJ4xya
         4xTLRWQHLv6EJbwXJo+iupg5GqmpoS0+JXkxt3syJTqIn6d64kraiBwFonrA8pu5gGHr
         iI0njFcfcgZsV2VBc/0EvDrZn41IXBO7HlaNeEiUZs+bH6Im80XjzaCCbLy+a9/DhsCN
         3ceoJbZVAK2ohge0zTCNR+qrspBNexqhl9Qiqraddv+A2w5imay5hmh6AXEjrrFGG+Ns
         CFiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786162434; x=1786767234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4UK+N1D7eZ3gh+QYJXokrWxjuw5VKrcGy+f6JcSXuM=;
        b=b5Kzoowhlgqwf21M3r7LghuDOP8n3t8kv79Oy6GnxdlRg8yRAxsLCO4clquC+XEoXe
         rlHnt9s9e9pGVAeiBnepN4Dqp2MPtBB4OsyvoBAB/aDuAjY6I9Q4N2CBZYAO3pvgmIy9
         B6xdWxGOFlfleYh+5oIqXGiWRgJzDlsHCTSq/z6kfVYl1AG8bxXVWgwyi2iVu1qweEDv
         qDOPbFU18j4dJvzxUhOqzDtQj1ghA8a4GpY+uDVFlOpHnzllfXTNS6XCzeTDRZf9ZV07
         w+9vZ8WX0BHD+XVWW5B/OMnaLh1QDMub+3H8yPfronCdJUiitoTJRBDs+bMLtGRy7v9r
         w44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786162434; x=1786767234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4UK+N1D7eZ3gh+QYJXokrWxjuw5VKrcGy+f6JcSXuM=;
        b=ijWZJ4foukBfj2+6ly6UJujr6+zWuWVgSyWeGSL9OByi3cFBHMOo34JAXv3tVMmycd
         NIGIiB9pgs3IwdvZ6TClltuXdcnD5wCvBfVJodR6JOd/9wyEoW1qoIMwsndRLkeK0AiY
         TrAmV5InB7Faf0VJqUMc97vGhbI9PugXX4rJF8DX72ONO2X9bJyNX35UJzV6xGPxd+go
         TAS94evwfFUrd3pWYyqxif0ftnfYWw+mFvxTyhQOe3OigvoUpgfu8utrGnK6bFr3jLbN
         rBkuyQdMLlmM3efzi8XA3Tht/fDtlz/LMAa7/jOxQ7KfkJ9ZLS1EPGKxVCUlolz28xgW
         jozA==
X-Forwarded-Encrypted: i=1; AHgh+RoMqpYny9ZbRV8DC3sK69OOT8TjPP1j9EzmFHg/urI/zMTNoIL2bfbuiORIujB4mlVgCbrcGlRtYv2qvxK26RlX@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmd6lo+ey2bTEtI7CSBtivkJnvWRlsjlJFAYuS6X9r3Dy8Gvv
	Z8FPxm3WerSQzQLkcbwcx1O6r46T137Ga88zOlPwL5DkjCVoLytPocfhwATXOgY3qZuU/b+Y4QT
	p46tj9JuYlTKyfyxVOXYErpazSXY5JVVxxss6vSyV
X-Gm-Gg: AR+sD10v+2eZAN4ooAXuXIEKBEo4d6wwa9xn+PMLDoNp6IaFwmPpkk8kvyJMcMWi6TS
	Ck2DT/9HIl9+lv8Vu3O7UlDfWLgeKsZSbX9nBDvu20+uLndU4+jSWOpBELZ+DC8pcc2HrTKgM1f
	2GUhwQFBVsOlooAMWXPi2I6ZVXYykNGAwhDoAsmpoSa01TQMNX1sj8DpjFCemxRhD6lnatIxyX2
	I2AjwbwTxhhnJeQsOVvDUhZEWCdWUi8FUN4ZDaouxRIHB2TIrBygsv3m5YxfrXgCTz9uxhfGWAj
	m4TyRBNu97874ykcuHUB9K3vvtmGMZzZ8wdg/c7qwGomVA==
X-Received: by 2002:a05:622a:d0d:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-52d28158dbdmr3544431cf.9.1786162433527; Fri, 07 Aug 2026
 21:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807104913.1784943-1-jremus@linux.ibm.com>
In-Reply-To: <20260807104913.1784943-1-jremus@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Aug 2026 21:13:41 -0700
X-Gm-Features: AUfX_mxDRuh5UGGtsR2bBKFmY2D2g9rp3fFigNKa7QRRZfcyrxDIcOjJPNv2T3c
Message-ID: <CAP-5=fWqtWQ+vA5-8ieARsVWqt-D3pUc1+NdwqEJ1F=jCkK86Q@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Improve frame pointer unwinding warning for s390
To: Jens Remus <jremus@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jan Polensky <japo@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:49=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> wr=
ote:
>
> On s390 the kernel uses s390 back chain instead of frame pointers for
> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
> USER_STACKTRACE support").  This is because frame pointers on s390
> cannot be used for stack tracing. [1]
>
> This requires user space to maintain a s390 back chain.  For instance
> user space to be built with compiler option '-mbackchain' (instead of
> '-fno-omit-frame-pointer' used on other architectures, which should
> better not be used on s390 [1]).
>
> Only few distributions and users built user space with '-mbackchain'.
> Therefore '--call-graph fp' may not produce the expected results.
>
> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
> added a warning for s390 that wrongly claimed that "Framepointer
> unwinding lacks kernel support".  Change the warning to hint at using
> '--call-graph dwarf' if user space does not maintain a s390 back chain.
>
> Note that '--call-graph fp' may also be useful for other applications,
> such as OpenJDK maintaining a s390 back chain (does not require JVM
> option '-XX:+PreserveFramePointer' on s390):
>
>   $ perf record --call-graph fp ... -- \
>     java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...
>
> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
>
> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>  tools/perf/util/evsel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ea9fa04429f0..c4d67d1b35f3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1080,7 +1080,8 @@ static void __evsel__config_callchain(struct evsel =
*evsel, const struct record_o
>
>         if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCHAIN=
_FP) {
>                 pr_warning_once(
> -                       "Framepointer unwinding lacks kernel support. Use=
 '--call-graph dwarf'\n");
> +                       "Use '--call-graph dwarf' if user space does not =
maintain a s390 back chain "
> +                       "(e.g. is not built with '-mbackchain').\n");

Thanks Jens. The text was based on:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/s390/kernel/perf_cpum_sf.c#n853
```
static int cpumsf_pmu_event_init(struct perf_event *event)
...
 /* No support for callchain, stacks and registers */
if (has_branch_stack(event) || is_callchain_event(event))
return -EOPNOTSUPP;
```
The backchain option is never tested by perf or apparently in the
kernel, but this warning is supposed to pre-warn about "not supported"
being returned when frame pointer unwinding is requested. Of course,
lacking an s390 I've never tested this. I can imagine the warning
being overly broad, but my understanding is cpum_sf is the only PMU
capable of sampling on s390.

Perhaps what is needed is additional text after the "Use '--call-graph
dwarf'". The existing initial text at least appears to match the
kernel code. I'm not clear how the lack of back chains would be
reported as an error code, and this could introduce confusion as we
have lots of stack, chain and branch related terms in the perf
codebase.

Thanks,
Ian

>         }
>
>         evsel__set_sample_bit(evsel, CALLCHAIN);
>
> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
> --
> 2.53.0
>
