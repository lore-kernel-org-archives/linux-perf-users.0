Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793826586;
	b=19tSxf57x3QIbWT9AAVlhGC/JrzQTT9h6jUfF8VScPP341I9lM2l+U+cA3SSijP/4nzE
	 j1BXKNpPod8xvcUXNzAtznzWfwdHUQfOSqM7MgMezr1eStN8af5as3naAzdKeWfQW09vq
	 ML7G1yCMHzttFGGsM8ZAMbHrgYuHejXaNJCPEvbWR4FvuvrI4InALvAgUyAUV/IESbrdd
	 2EJx6o2linGaCKL+Eausl7pUfV31WA6CdRESGhQkvyMpzbA+7WoQYb+Hf43Ylm+pk1CMY
	 uhC5b3wvdmxioyVSNddqhdj2DR9uIa0tNP+3GFRRGca6Sc/tQKJE+VFgtsMsHcF7Qpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BiNdbumrOd1SkEa6d8Ju72ty6OWDEKr6FE4yt3e0p8w=;
	b=o/i0FndWb7hmZPWy663ZRZQTooqFgqocaXrLLx0BjlShqaXQlIswXOhpIwQKDvMsQZTh
	 4Zoy/qy0v5i0OqgqiFzU/e2302QD50VEHQ9+SCC1KhQx9UmuF3jgq/wX42aggkOC7vewq
	 8Ii8qQcIqqrA+QEzk+qTEScSYZ1Y78gQIdqQ03FEbEwGAqYGyj0RINhw9zu2RwwG2x6U3
	 hujP77DX0cocfFCu92TloBiC3qDOa8h+x6pzcNcWuHFAHOpFSzN4t2JhgaAnnoeF+M4NH
	 A00UAsISEQs2LhRWnIO+LUsXf5BnugVUak05f9O7yGANkTummC0waxtVtzOX2iG9vkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRwj3MeN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C024607B9F6
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C024607B9F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRwj3MeN
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so1723563eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 13:09:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793826586; cv=none;
        d=google.com; s=arc-20260327;
        b=c5AX7bYfDmNyFWgleHQPt4KCwf0pNzAcgAE2mUaHzaXFH7DfeJeZowzbaVtdWw2NZ9
         cH4Hgr//gZLYieqFS+kIg2GuQcxXQOo9S5LXA3XBj7mOyXvlSwUbWldYXXGqqeXggXJj
         7mATMqcf8x+pQh+55/5bOd+finwIElZ8++YvwehO8U+zLHE+7tzQrr3u8ZYGvilgWmQf
         tJDaDju74m34eaw62aCvOoxwtPgOS68HLwzwBgwMQbFIebzSD7I++CnnbmbJqDIweAcx
         MxtC2W1qGlHp7jL0gTW8RE49TQoU/Te5UFf2NOYjrFel435KXBSfgBEowLQA1WpfiU6E
         LrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BiNdbumrOd1SkEa6d8Ju72ty6OWDEKr6FE4yt3e0p8w=;
        fh=Q8Rl8VVLu77jEePVfZ6MgEDO/7aNLdKewknwck8Mi2w=;
        b=nA/n/RQUkmw4vS8imB7uZVsd0NfItUpC6o23eVTSd/qSA5gBroYcZ54pUqcCT8i6u3
         C6jFiDvk0i2qCfdinoZYbLmq1GqiaIM7D/Fx3MMIPvaGPmGzS9zFj3DX5Jg09BBhK8jo
         WcdOLRlbH7HXIFoScmdnx1Xp6ZyaD7pXIIxmFtTuk0Q/IkGuxiDNr/hRpj1/nsMmbYyN
         Ar2BYCc6cKKOYyAElw9a3qTTNQbQ583hZa0dAgCxqE6QPemTNFLEyeD94Ojx4j5Ibwgy
         75FTNys7BNTHPx36xIWAzocjv35QOPFSQYDvSfkFiEzhLM9b6obNnlIREFmLHfrEAqTE
         yGdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826586; x=1794431386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BiNdbumrOd1SkEa6d8Ju72ty6OWDEKr6FE4yt3e0p8w=;
        b=rRwj3MeNjWM0dHqE/pWNUvXz2va6j4DIyFL4slC2zvEoEsmnqhlbQIm2z9/YBQtO4Y
         mPuiC1FXZSSOwRzAnULW6qnAQLAXTUensK3N9qFZa2pcRQNE5FouU4TwO8oqDf24HpRR
         0KLZ2+AVv6WB2x/nQ0Z/01AbM3bov48ESgFJm3LD+bFVp+7COuG1dLDpcI03V93Chw/M
         1LygzRawRcgb2xYSBbj3wvgUBEIVJtk0Ds4+YYCq3gMkh8HgBmbpsma1Zsh3JBgaBX5A
         7tTlZ9YjcX2+ZRU9WUh2ll+H057mzbqdJ84SnYCk7I+Fa8yhabzDfV3K0ANCId4Iiaao
         rnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826586; x=1794431386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BiNdbumrOd1SkEa6d8Ju72ty6OWDEKr6FE4yt3e0p8w=;
        b=wdF3FCXBr02UID0vFGoKwGl3Oa1Ox+ZeyAmL5bLZ7kaVe7I4JAmPyilX0wrC8hYfXv
         urMIDYRI+GqR8kNJA9UI26BklEVtxDi8pL8x7qtBKd1g4bK030oL3mDmc1FqX1DDfQZl
         j4/qiEGlBOJuf4GcYuHBzRbGhwg3ynj69mEHsO63hVP/9dtOZEVXZucBOX3aC1vh70M2
         6kUrrLtUNJU9wH2WrswpB6yPtzdjJ0GxA8IUPHziZvGmdWdlG4fSrCstAOQiNrd9Kx4T
         orNZTrPIo/0hyLVRQeH0WTKAScPwpeXDFZFidokMOqHWg3zI/PtfnKdzWTtH733nPnkK
         TkjA==
X-Forwarded-Encrypted: i=1; AKwUvBzudjsa2wCY8kdD6e/OrhVesTMxmTO/fyokbArKQ3RWND6OZs+tCc/mFLm7SjoIHCpax1idinrQh8v9tJnc7VGD@vger.kernel.org
X-Gm-Message-State: APuU4Z96HLn1m2vvSLTxXxI4d+RpaDlpZ46T7VKXNe4DYgLiVERWHEe7
	NwQUrAXfQv7HISeFBiDIxmqfY94OLsQESoqjJStC7g1d4b7uxJIO68AD2RZOWvMaigzHQB4N4O9
	sAE76vqUyy1klM/vq+M+Wi9z8NJvGL8U=
X-Gm-Gg: AYBFou2gCf73zaxGOEESewCLoWap9wrfq/h8yruiEvzOSLKG0bCnb1hkn6d1skzLut3
	6qQ145Wr0IWpXBftD9ofryu2oXO0GDSE8KarvE0QBogG/+e2TFKfS+eoY/Hj1x2iuocsPerzlxk
	E2Kr79UveiaKKCLUkli9zrXWu8lpRW1p2JsDZakgWN2ogcfeT6AuN31zaBffZGbB3WhLJHBNZ5g
	j/HKPSbhNDbDoxdK7iUudNaL2rNgKst5w9AOzjG9b4Lmo3q501xKqUS+p1avg414iaN0in9hEBe
	oTH622L0dLgf0soY0f1FFqtbIuqsxUHI4IGIly3R7DHdrQqy66OSqimHg7pAzSr6Ccn5jTHbjUC
	ST2HyvcdoR8bB63AgLkiOa+B2siaQfvRlY3/ZFu7IYM4f3hcns35LwpIWuBbqIB14i12Lq9DKnu
	Cos5kOhB/6hvnkMYpdCRSREUM+/C8mpS4phAaAcyHLNPIXSRl3D5si4Hwn49tveAKmt0EnyAlWs
	DpFpx8=
X-Received: by 2002:a05:7301:22a6:b0:369:f9c4:1fda with SMTP id
 5a478bee46e88-36a42489041mr32982434eec.27.1793826585524; Wed, 04 Nov 2026
 13:09:45 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-perf-output-v1-1-df33a0368cf2@arista.com> <auuZHBawk2--flHW@phoenix2>
In-Reply-To: <auuZHBawk2--flHW@phoenix2>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 4 Nov 2026 21:09:34 +0000
X-Gm-Features: AclHuK-D9hZgAv3P0BlPu9bgWKZEFr3G6b2hTXFkQu-_WGog5aWZAYQ8QHEOYEY
Message-ID: <CAJwJo6bKK+sOwwj3iaxh+JA2+EkZ2HHhmfyd6gaNQYiQoQGxWg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Override OUTPUT when building internal libraries
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dima@arista.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Nov 2026 at 20:44, Arnaldo Carvalho de Melo <acme@kernel.org> wro=
te:
>
> On Tue, Nov 03, 2026 at 04:55:21PM +0000, Dmitry Safonov via B4 Relay wro=
te:
> > From: Dmitry Safonov <dima@arista.com>
> >
> > After commit 1572ba36fbca ("perf tests: Improvements to build-test
> > performance"), building perf with OUTPUT on the command line fails:
> >   make -C tools/perf OUTPUT=3D/tmp/linux/bld/perf/ ARCH=3Dx86_64 LC_ALL=
=3DC CC=3Dgcc HOSTCC=3Dgcc LD=3Dld
>
> That '/bld/' is not reflected in the next line, copy'n'paste mistake?

It is, yes. The path in the build system is quite much longer, so I
decided to cut the noise and cut it in commit. But my eyes have
failed, and I should have re-checked it on the short path and copied
the output, really. Heh.

> >   ...
> >   make[3]: *** No rule to make target '/tmp/linux/perf/libsubcmd/libsub=
cmd.a'.  Stop.
>
> =E2=AC=A2 [acme@toolbx perf-tools]$ mkdir -p /tmp/linux/perf
> =E2=AC=A2 [acme@toolbx perf-tools]$ make -C tools/perf OUTPUT=3D/tmp/linu=
x/perf/ ARCH=3Dx86_64 LC_ALL=3DC CC=3Dgcc HOSTCC=3Dgcc LD=3Dld
> make: Entering directory '/home/acme/git/perf-tools/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
>   <SNIP>
>     TEST    /tmp/linux/perf/tests/shell/base_probe/test_line_semantics.sh=
.shellcheck_log
>   GEN     /tmp/linux/perf/arch/arm64/include/generated/asm/sysreg-defs.h
> make[3]: *** No rule to make target '/tmp/linux/perf/libsubcmd/libsubcmd.=
a'.  Stop.
> make[2]: *** [Makefile.perf:827: /tmp/linux/perf/libsubcmd/libsubcmd.a] E=
rror 2
> make[2]: *** Waiting for unfinished jobs....
>   MKDIR   /tmp/linux/perf/tests/shell/lib/
>   TEST    /tmp/linux/perf/tests/shell/lib/perf_metric_validation.py.mypy_=
log
>   TEST    /tmp/linux/perf/tests/shell/lib/perf_json_output_lint.py.mypy_l=
og
>   PERF_VERSION =3D 7.4.rc1.g45e09a6dbb2d
> make[3]: *** No rule to make target '/tmp/linux/perf/libsymbol/libsymbol.=
a'.  Stop.
> make[3]: *** No rule to make target '/tmp/linux/perf/libperf/libperf.a'. =
 Stop.
>
> Minor stuff, I'll fix it up and apply to perf-tools to send for 7.4-rc1,

Thanks!
