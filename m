Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA60182BC;
	Tue, 26 Nov 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643161; cv=none; b=MNcXwyy1Tk2Oawlya9f0yAXBslvoLjgUpcjWIe1AogVaDO7RLFMiBxK34RKht1OhQ/s7XjkYsi+bkqmlr9Fhak+rs6QhlwRJmpHxOmeb1UAhKv4XJGpo7gKsyFOavaPjdJvWWqwv14eG8sI3uendw8JuHhR90Hg03huTnS/aORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643161; c=relaxed/simple;
	bh=mY03VpsJJqMELHECKen20IGCRx/WgeuV9DS5VVd2Kmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA5l5xj6+Jt7NRlMU2UZr7Gg9xVoahbhOx1MqQJ6pm3TJvWNwVMC6Hfoi8lOetpMWHU5q/euN4bksf1my2XAqJyFRxaTtLYVsRFCMGBUT4STY/+AuVqm490+Pg9pKAajVDSYkr6ttPozujmr3/PWBgiugRoywa1Bl03xC99r/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC1QMaIc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC1QMaIc"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ee79e82361so57911087b3.1;
        Tue, 26 Nov 2024 09:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732643158; x=1733247958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDFaDoaUbU0YDEV8A2N95UPpOXgvTMECrJUgSiq7MTo=;
        b=FC1QMaIc8lfvlFqW9H/tHiTRn+xt5Yg9ESgyyyvD86ptHsHNE5RPtPnzqzXsYhGrZ+
         0lzJSv6+FSJrB/8SjfzHEaayexqsLBBP2h/JqmCObf8mkLAl+N0Ia7i0v49ZyeGtDwC5
         BPTAqPtcNT6+kYbh0SJAkUgwEcEU0zt+UoF8Pfb1NYk8tImgakHHQk7ZjH5AdKc1UXzE
         lAD2Ou81WMz3byF9oVJ0+C3iDIQ8GRnSFbDi5qluYTA1MMdIvu7FYKOLT6gVZ/S6hErQ
         KCf5BDoxpvO5e++LwVLIAq54eGkBtxEzNb14pdkas2BvX+wBG7gaX7zMHK1X3m3TzGey
         Tfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732643158; x=1733247958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDFaDoaUbU0YDEV8A2N95UPpOXgvTMECrJUgSiq7MTo=;
        b=egjFThA0ZYzV5ggq17wTwRl7OQypst1/qDg9YrjK3yE/IS055ATK4pIpbTZ72mta3F
         hpi+dVmN/XBDfclcg1HHITIiortmMZH9inCBB6+enPnbPRE22imrr21nH1UUNXwaPuMR
         8RjY7a1sjoP4yOEJ++HcUXWAPJJixYh347NmB1xQrOK4EN8Q1TPd+L9ynB0S1XUSiXER
         KTI0NVjfj/PzoWxaycBMc82opedIjj2BpyOWfQDzPhrJN7rLT/sqDFLceWYaJ+Q879ex
         U4Do71thQjauoq9Jcn5cp/I4y8RvhUAFR6GjVLr6Xfg5V6WINx6D37FnPiOBsJtdRZMZ
         7DQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTUQbG7St7CavjOAhWyaPjmCdK7+cQteDi67ebm/i5EZlrWRVqToOOShPP8Kmsg14FT6FsugSQt17reMg=@vger.kernel.org, AJvYcCXv/2aI7wlHMUB9EDwhcAOlYxt2X/EpgRETgaXlwle5Mj++Q2XZyY4qDrsi62Yq4tusjGRBACzPEn0yN9f1d3rlCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVTRq4AbYJZUbVQQHKDQV9B9jISUWfJjhA51IXkYS+X7dvJqm
	89Lwr8RQqRHQwa7AlYtgjMpm713XkCuwYr6min2YsH+pAlnMWFBiWEuBb5OOHsNd9k6ShC3Bh7d
	aZxUSFxoBtvzRG/2KAAGmKO8zHAU=
X-Gm-Gg: ASbGncuj5+nalu+z+IRNZB/YvZ5WmgHV6ASTJstXJ4SzlB1ISE0KOM4c62AyJhI2NQT
	wg4ZzyYgrOUkRLs1zEOewBM4SzIlpVlr/
X-Google-Smtp-Source: AGHT+IH5Mbh/SMLM2wJi9RWhj0dwkJbVOV3z/saPgVQM+PC70Knl18Y/CK9eMOdmqxyHeWEx6a4Kd2hfazmGPktIC9I=
X-Received: by 2002:a05:690c:380a:b0:6ee:4855:45de with SMTP id
 00721157ae682-6ef23dcfa06mr38894167b3.9.1732643158464; Tue, 26 Nov 2024
 09:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123005512.342079-1-howardchu95@gmail.com>
 <20241123005512.342079-2-howardchu95@gmail.com> <Z0X8KJd5LYrgUJUh@x1> <Z0YBiu9XdstHmjWr@x1>
In-Reply-To: <Z0YBiu9XdstHmjWr@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 26 Nov 2024 09:45:47 -0800
Message-ID: <CAH0uvojGDUwSzMmf2FE8He9DB59H0R0p2bHKGJRDs9eJjRXFhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf trace: Add tests for BTF general augmentation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Tue, Nov 26, 2024 at 9:12=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Nov 26, 2024 at 01:49:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Nov 22, 2024 at 04:55:10PM -0800, Howard Chu wrote:
> > > Currently, we only have perf trace augmentation tests for enum
> > > arguments. This patch adds tests for more general syscall arguments,
> > > such as struct pointers, strings, and buffers.
> >
> > scripts/checkpatch.pl has some warnings here I think we can address
> > easily, some not so much, like the SPDX that we need to add logic to
> > 'perf test' to noticed its the SPDX and skip it, looking at the next
> > line for the test description.
> >
> >
> > The long lines we can just make them multiple lines with the first ones
> > ending in \

Sure, thanks.

>
> And while testing it with -vv:
>
> root@number:~# perf test -vv btf
> 110: perf trace BTF general tests:
> --- start ---
> test child forked, pid 242944
> Testing perf trace's string augmentation
> grep: warning: stray \ before /
> Testing perf trace's buffer augmentation
> grep: warning: stray \ before /
> Testing perf trace's struct augmentation
> grep: warning: stray \ before /
> ---- end(0) ----
> 110: perf trace BTF general tests                                    : Ok
> root@number:~#
>
> The long lines can be solved like:
>
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -17,7 +17,8 @@ trap cleanup EXIT TERM INT HUP
>
>  trace_test_string() {
>    echo "Testing perf trace's string augmentation"
> -  if ! perf trace -e renameat* --max-events=3D1 -- mv ${file1} ${file2} =
2>&1 | grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ r=
enameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${fi=
le2}\", flags: .*\) +=3D +[0-9]+$"
> +  if ! perf trace -e renameat* --max-events=3D1 -- mv ${file1} ${file2} =
2>&1 | \
> +     grep -q -E " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ =
renameat(2)?\(olddfd: .*, oldname: \"${file1}\", newdfd: .*, newname: \"${f=
ile2}\", flags: .*\) +=3D +[0-9]+$"
>    then
>      echo "String augmentation test failed"
>      err=3D1
>
> And that " +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ : +"
>
> part is common to several such greps, so you could have it as:
>
> prefix=3D" +[0-9]+\.[0-9]+ +\( *[0-9]+\.[0-9]+ ms\): +mv\/[0-9]+ : +"
>
> And then use
>
> grep -q -E "%{prefix}mv\/[0-9]+ renameat(2)?\(olddfd: .*, oldname: \"${fi=
le1}\", newdfd: .*, newname: \"${file2}\", flags: .*\) +=3D +[0-9]+$"
>
> Or, since this part isn't interesting for what this test checks, BPF
> augmentation, we could make it all more compact, i.e.:
>
> From the default that is:
>
> root@number:~# rm -f before after ; touch before ; perf trace -e renameat=
2 mv before after
>      0.000 ( 0.037 ms): mv/243278 renameat2(olddfd: CWD, oldname: "before=
", newdfd: CWD, newname: "after", flags: NOREPLACE) =3D 0
> root@number:~#
>
> We point perf to a temporary config file, using mktemp, then tell it to
> not output the stuff we don't need while test BPF augmentation, making
> the output more compact and thus the regexps in the perf test shorter.

Sure I'll do that.

Thanks,
Howard
