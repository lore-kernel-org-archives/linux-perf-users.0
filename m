Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3923491C4
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Apr 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489086; cv=pass; b=N3s05zTe/qzjCL3VqtGGbhg09w6fNdD6n8WzsyDBlbuvueoyLtt4UHVPYyIZR/gOhuoW53CXQ//hHt8iDaB2lHk0/4a+oliS6gWSHTM6dJkweRG7zRpWDw9IsNiXd00AsA6Sp9ojqjbY9/YUwYHntODIItIhJ6WI3rQPqyLrf2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489086; c=relaxed/simple;
	bh=uLoeCIltIV/+RQKE6bpskkDGmbsHHy8bI8CVux9obV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piQhMylVNrvACpbHKwYswo3YLrui4ck8CTdY32Wbub/8F1XxJbH4Eqy3c3zBWatkSTTjLLYyTtUP7vIgeBKVkSL8XjkLHIJODC15s0q+JRt+tf9QjrVrFDAN6E0TvIhdYQ7KQviXlo/RkSUnDLUn0WnOthwiTTRpfUjSFfIEdp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbxRRq20; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbxRRq20"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0b260d309so209405ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Apr 2026 08:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775489084; cv=none;
        d=google.com; s=arc-20240605;
        b=XAlsKX3HTt5PDLzgZVPuu+aah8kIlb7Gw4kh5mrgv85ODA1X5+G7cUflEDOvjm8wpG
         09JDV/AYwoA1wWfpUjwJ8V+AMkwLzgVtKdBAGEC+qqbfhwcWWSERoePvRSeasr46FfHF
         zBiJ3od2AVXOqEWH5M8RBGpICSPZ+m+ed8NBtKP8Gca7Pb88a4RZTccuxRYFCRHOAWQh
         YLpe4P4jzWsCloUTZKbFjePT3SWWtv8PVlDh+YlmiyiIKk/kxAbkTKOjm7BX4BnPI+6P
         DIPb4CMdKMKNa8C+rvsoBdITnkR6F0NB+oV6ie6y9U52KsKsELdcuDBrCkMn96CT0bEI
         Wf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uLoeCIltIV/+RQKE6bpskkDGmbsHHy8bI8CVux9obV0=;
        fh=FyNqMTokAC4IhA96rVCDw/2OcaF/2QBGi+nnj4bImMY=;
        b=BnmjcZD7vAJYwGdxK2GEkY7+La839h+DxtqftxyQY6VyPBhPTNEGPb8oW0+OnGlfQX
         aGgqX1+ub+6bTyEaG9GwZHCTQ0ScKBXF0jv7sLbGingXr1O3az+dBUTWpHySZ9F95LHY
         DXu8tgLSclMymegOxG57PiEfHNYKJOMXMSNJgVlPChOejbGo7102c2nwic4lWQKDlvGC
         My9MS2msytUZFAhJISKFDjetOCaoX19Wksfl1oAKQBh/QIdIG/s0H56enFTmuliCyNO2
         50MyrboxH356eilqQL6GxTRaKvf0DzseUYHvA/xSEypMQGkbi8RigHXBv5pNtpFPqwd6
         WoLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775489084; x=1776093884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLoeCIltIV/+RQKE6bpskkDGmbsHHy8bI8CVux9obV0=;
        b=LbxRRq20omGeWQLfOxexn1t/124tmNnv7vSerpmvDfQSgkTp6ghRy2ZMGVav458I38
         E0W2Gd7OhokaACtNQRt6ffQdpgYZ2EwDrgGLEvWHXCjj0z8/zZHhlGJyDB+ambWtXQxg
         YAn8uILcZfpj6xyxnl2VoepoeU/qX4by08Vf15JSjuzLrbZ/Khrd7ib/EumK//pkgd4Q
         Y41VoBiVoM3z1aGutO6CZEPtfz0/0ON9Kil8fRgzJNbV4XTXtAGFWJlE5aytTPH3TqIj
         JojTs2oB25P41bGwwOZJN7PCBDFpBzibDPiMLLjAKceOxZrJTGD45dD3XBnOh9kKTqNS
         N4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775489084; x=1776093884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLoeCIltIV/+RQKE6bpskkDGmbsHHy8bI8CVux9obV0=;
        b=JaEBpK+g69nBKu0Ax3BTxgpa6jWZQ/z3FpxYHQLl3TE8k7FYzfNYxByFNzOCsqwsp6
         HVQ09SDOVWJZuFVVi8x+JHVqlupfK9q4T7Iq6Kp/y1Q47MaejHljvprZ0TWQY9cKeYAj
         lh8qRpkQCw1Yytz0bODctwZSy7HnUwt8HGy2Z0F3Fs+sCMP845CMIYNtfRhu4Sv1deRl
         gzyNZ6p6r/CwqmNVsw1NZt/j3xeDfAAbkZ/dpz2n8+56q2iHCDhaisDyRVrDrPjCmUxh
         4Yb6ifOAzxPvOnLeX9DBuMTFOZVMva5SgTlUXDeDgw+xvG8wIQrIJe/p3jfAjwSdh8uB
         Tdjg==
X-Forwarded-Encrypted: i=1; AJvYcCWbGKh6FzgxF0umknUPYTFoGmkklfBYTn4CngEmqJa18JScfyi41fd/Egp/4wJOPPGbnZW09oFf8iLjArtHmZyL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz72fQEriqhLnQ77DgpN2cpAGAXFz718lvJzPqODqQzMTgiek7
	aVUHwwbmtlKnzygrVsl6vSlzPW45ZRBy0doUABUdRxCuxxfrFyox/fmqlqygIsoHJXT66TlEiFb
	ZAyP16GiMo4QsC4Q7FMrGnL0hBv8OQFCKJsy1Vooo
X-Gm-Gg: AeBDievg/8bSU9buZ/tL+ifCHGGid7mRUS9IUa50fJnS8aKUL7DNxlEgvFREw7IRC0T
	RkFyRUk9Dy3j2evl8tG8WYZm6nvDwJeEpqOc4aIxneQACVQ4+AbNM4Jwfa4lV1H3moFn3ZFgrY+
	UwWDie8kkXY1EBX6Z9qbumrSz0911vCKgpHMrIn6EHha9ZZ9h/jXfjE4W4456aOtHHGsNSrH7o2
	YmlKC9bdmjLG8wm05zRLGFJ3BKqa0txWY59XXTyRw5rZ2OPh0opGCxdZaGNx2DgdnLhJ1C+ET/i
	dZLSjmWfpd3vNxMn0D5toflPy+vZmRZjzKoEPA==
X-Received: by 2002:a17:902:e545:b0:2b2:4a2e:5dd5 with SMTP id
 d9443c01a7336-2b283f04a30mr6189795ad.3.1775489082914; Mon, 06 Apr 2026
 08:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
 <20260404034325.3172592-7-irogers@google.com> <adNNa1lkyMXSyhuD@google.com>
In-Reply-To: <adNNa1lkyMXSyhuD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Apr 2026 08:24:31 -0700
X-Gm-Features: AQROBzD9I2V49obxc7lmG-oFxvsP5oB5M4QJ4jVT3smRdZZR9k5jQRtKp7gDDmM
Message-ID: <CAP-5=fWC7WtUk7iT4pVLZC8aJYe-FwAhA03LH0rn5AFyL-jeKg@mail.gmail.com>
Subject: Re: [PATCH v6 06/25] perf evsel: Refactor evsel tracepoint sample
 accessors perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 11:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Apr 03, 2026 at 08:43:06PM -0700, Ian Rogers wrote:
> > The evsel argument to evsel__intval, evsel__rawptr, and similar
> > functions, is unnecessary as it can be read from the sample. Remove
> > the evsel and rename the function to match that the data is coming
> > from the sample.
> >
> > Add bounds checks to a number read values from review feedback. Make
> > perf_sample__strval avoid returning NULL pointers, return an empty
> > string instead. Fix the function type to reflect this, catching a bug
> > in kwork where the string wasn't being duplicated.
>
> I'm not sure if it's a bug... the string was never freed and duplicating
> it would create a lot of memory leaks.
>
> Also it seems you still check the return value of perf_sample__strval()
> if it's NULL.

Yeah, this is one of the areas where working with Sashiko is
difficult. The kwork code has memory handling issues, and each patch
series has revealed new warnings. I believe the issues are fixed in
v6, but as you point out, I haven't addressed the pre-existing memory
leaks. I don't think we need to overcomplicate fixing the evsel in
perf_sample issue this series is addressing.

Specifically the current code will assign to struct perf_kwork name
both a value within a sample:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-kwork.c?h=3Dperf-tools-next#n1021
```
work->name =3D evsel__strval(evsel, sample, "name");
```

Or a strdup-ed value:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-kwork.c?h=3Dperf-tools-next#n1152
```
work->name =3D evsel__softirq_name(evsel, num);
```
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-kwork.c?h=3Dperf-tools-next#n1125
```
static char *evsel__softirq_name(struct evsel *evsel, u64 num)
...
name =3D strdup(sym->str);
...
return name;
```

The name's lifetime must match that of a sample, which seems
ridiculous given the ring buffer... will be overwritten. So in this
change, based on the Sashiko feedback, I've strdup-ed the names to
avoid the name pointing to memory within a sample that will change
when the typically stack allocated value disappears. Sashiko
originally complained about a lack of bounds checking, but then
complained about strdups of NULL, etc. At some point I have to stop
addressing every issue within the codebase that Sashiko raises, and
kwork seems to generate more of those than elsewhere.

I think it is pretty obvious the kwork memory handling at least needs
a free function for struct perf_kwork, this can then also free the
name, but refactoring and fixing kwork wasn't the point of this patch
series. We've just merged the tests I sent out to provide minimal
kwork coverage.

Thanks,
Ian
