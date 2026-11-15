Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794765713;
	b=CtYlxOiLyCv5ECuD8RereNhRtSQ0ryhPHnu23M4u6Or7/q84XYj9YPtGOjB9clOzn2zH
	 kmmvSLk/qWT/aowX1w2IA7uHgPy0tXRC1IUP4SsAIDGdZ6vIbAggz/+A7jZ5LUnNTsKQw
	 wNh3W4nFgzHxPniZZcUncXOgw6Do97PJ4RijsKSaIZYnqn8lJDiQa3KzfUMPJmmVnPh8N
	 D4jdcNQXF1njK/2pq7hZKLX4Nu1oBinrxnaz/d+atE5CY//M5/pOCDos80xHu8Xjl7SMt
	 fQnrz5kZKbYysLUvljIiVVbgf7rXwL6gL9yW+RqpP9QsUA7BjMyVjsARJard2hkNQBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IpjoFAQdvouRdlXBjzoC7wJxtan+tyigmF2bs4+iRJA=;
	b=yTOT2tiIRA4MvH7PsRdicr+w9UBwjWCspXFcGSQmGZ/UINuFayAuI5LFWLZYcPTcZKAb
	 PanUcQ9eTRdxP/zRF2MfxLckLrDtG+RCZ1JAdsSFlKT5tWR9qp4H11qWPhi5xNG6AwiF2
	 YosLdpfCsMWYWws8Z/ktPZ8k09Uq+adU5fPYvViIyx3O4SGpLacZd1Xj1dEixuFBYl9zj
	 S/AgWvbX2XFJn9Uyx2TrQJ1X/p/Hso1V4vt39uc5Mol1zkWCzglQ/E7BlCqM0FxD/H+/F
	 D90h2GuTUhtvNInpMrmnTgHb0qqSJJ46+8bqMUlIt0c/6dfGf9IUhxTC8Yjt8E0xiYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=enY0xJqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70B606A882
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 18:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D70B606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=enY0xJqW
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55be673e029so199901cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 10:01:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794765712; cv=none;
        d=google.com; s=arc-20260327;
        b=ezU34y68Zi/Pp3xhs4AZyUD5RbevXa3I3dZZA8Yc/7xQyYWKaMUNxc+pWu7x/V/N5l
         1QpBTqEhw/heDhlifCnfzHtu97HsXi1MT3McPZSzmTQx6+TIF60BiFgFZT8cG3D2Q+DZ
         PYD6LofFQiQRIf8RKvbUH8eiqYfvne3/fi3UXDz+CWPUs91eLpB/JzCCUdec/iKMS5CY
         Dtqq0bNRKh5tif1L/kal1XzIx///HCYe23ysUo3hdkRqdT0NfPdgXfmsI0edOtfIl/18
         WU3j5Tn9jagCOBfax7+zYkjkwsRM2Cj+1MwMp5BIaFmxcWJur4E0Cdv2PEiZFqOcFRa0
         QTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IpjoFAQdvouRdlXBjzoC7wJxtan+tyigmF2bs4+iRJA=;
        fh=E2gr3qhG0phQSWNXTBs3XsEiUMmY27mBC/14C1CD+e4=;
        b=AUWlqSWifEuxdajBtmWhtdMjzk1qf5P7l+MHy7i7sIDKPfojxiGQ4X9jpLUb72VNW+
         D/8Hl9dAAh/oHu94CSl7DROihuI0nVMZsph6x2oZyGFPwyfp35tBRL/VWNqXJA/okRX2
         4CHI01ZKdCIvE61TVNrUtrKe/0HoEPjtpKYdSsWwtQjWGX9P6kukcLH74m9R9fdAmjnO
         pARlPmQ52WYW/PMK6Eg7zVFqUdXsSGIGBdL59KD0mR+xzhHkmpgwiauA7z6FGOVBfxhm
         VXxTJNjBTGAbH1RBiAUbMuG4wpcK1fkn/HIHY9T0Ij7Z+v2QGkbnP98oPG7SMjisBoIm
         p/XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794765712; x=1795370512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IpjoFAQdvouRdlXBjzoC7wJxtan+tyigmF2bs4+iRJA=;
        b=enY0xJqWgu4I0upCp3MGG4xd0ic+I88iy6YvAB2xeb44xIIaRd1V97l9e/O3X1esey
         BnNdsx9NVRdayNtq/A8mpmYF+DWuejtCena6aeqE1B8r4WZg9rfZjatH6PoldzwFIPkh
         A/iyPcFje2hsDMw9LN/jailmtUhxxg+hKowXSOr+gFOKnA3BQN7oDM15qH/NAF4ClEed
         1CnCFv+htqcFcDIWqjY8tUMaH+z1BPEHYPBwGEej0Vt+UJH+yLOn1PkUZTk/npHMNjkE
         XBmds7gtd6a4hk2QvVtj8pYVxBfM9lyR0fKWKNrQqME9vV9Q+2SO1m7dZJ8ahipjumOG
         q0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794765712; x=1795370512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpjoFAQdvouRdlXBjzoC7wJxtan+tyigmF2bs4+iRJA=;
        b=OkS6gbveuwGOX6Xx6KhK3mEvkUwmIpjxkddDLYScOyvqiBZ+aPty6svCk+QkOwUu4u
         wS2ZKTZ8Nbz51dTwagpf8Vmf8n880L+ftpir2flH46CP5Q2a2V8qC7LsswLdRQ3XEGe/
         liaeW8/51zNNeI7DL9cZpECvJR6NewxuFS4kMEE4gYpxOYtaxYiWf+Jb6+KZ9Ta8IUgo
         3NGpy9KNxqwCpRd9XFroqNwCPhSGiA1r6s7ahSl6z1x8VwOPKvFBVZRy+u+ewH2USCU8
         HD/ND7q0qDk1K7oqsxiJUwFjGngZBBBk8Zc55J6RMX97U35i17FotAZs+Xc5LhCOmWsM
         WfcQ==
X-Forwarded-Encrypted: i=1; AL+hErFBW6V7DmMZr2X/Td4JOEzuUkGAjz3bfx1UNVahXD1CYSbHCZdFFbW8AlNCmI0W2yLbU2K5ijKVWbcWSHcGXfsL@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ca5kFL4lm4kqw6gcbRt5Q1vbAZBQax5O7EwysmhD+OZtnOVMs
	IxXC+NY8Rwa65Kl7OdxOeRecqrHWCXSz6tSq7/8E0qpH67Ev1ijicXf3+TInzQT0CjlsSBtQzCc
	jyqzRqagALoB/OTquci7et2tAQ45K/eV0U9gRZAN4
X-Gm-Gg: AYBFou1FFzAWsDAIaiMmdN9hRrJbPpUXP6zW3yHo8LpGYk4mpMAt0qgqiX5e6XCNozv
	AXm6wUPiYj+uTHnqATXU5ENaeZZoS+2hMP7zjwgGkkSjC0y2NM73DwSWKuivGswgbix5ZLNberV
	p25XzPUJyT41ELq2Lhg1IN+ozUlHi+ako6fyg+JkTCVMUmqFUl/kJfSWul4ioxH6XaUuF4yEK3Q
	1Mqf10C7k0zv7yfuwAL2PScPPRJ7SXS0ija2eLWkXZavS1NZfd5VeI3pFzfKpFXo1z4HVieHNm2
	VO/iW65GY/QRKbPbG1BZDY5aIL3M6Wp0Lr6eRXqIEyNM7S3rNbN75E0Sin6b1xGjYFjBLHGckvD
	4QapotWKOPLMNXqIrEW2QNtlNlkPK0ZSio0Rr
X-Received: by 2002:a05:622a:4d9a:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-55c69c30437mr24722481cf.14.1794765711631; Sun, 15 Nov 2026
 10:01:51 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
 <CA+=Fv5RBKVAdGgq=BGPmLXpczcB3qvQcSw8aat7nB2ePXcG4yg@mail.gmail.com>
 <avQKb-vBxTvMn1yF@z2> <CA+=Fv5SA6so5VjPzjj1tCNKxwOk=5ejj0YhEG483u_-RY+7NoQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5SA6so5VjPzjj1tCNKxwOk=5ejj0YhEG483u_-RY+7NoQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 10:01:40 -0800
X-Gm-Features: AclHuK-kcTOLPOTUA9hzFX_1_ZcS6vTo6b5Nqcec6CO684apf7lqlfr30UJRR34
Message-ID: <CAP-5=fUqDU4qcjHH4=t3NQpjS0m-nsHEw0YkXY9FVTchO0+M-Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] perf alpha: Decode ProfileMe samples
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Matt Turner <mattst88@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 2:47=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
>
> Hi,
>
> On Wed, Nov 11, 2026 at 7:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Tue, Nov 10, 2026 at 08:31:02PM +0100, Magnus Lindholm wrote:
> > > Hi all,
> > >
> > > On Wed, Nov 4, 2026 at 7:53=E2=80=AFPM Matt Turner <mattst88@gmail.co=
m> wrote:
> > > >
> > > > The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
> > > > ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carr=
ies
> > > > the profiled instruction's PMPC and its I_STAT and PCTR_CTL status =
as
> > > > PERF_SAMPLE_RAW data, which says whether the instruction retired,
> > > > whether it trapped and why, whether it was a mispredicted branch,
> > > > stalled before map, or was killed on a wrong path, and what PCTR1
> > > > counted while it was in flight:
> > > >
> > > >   https://lore.kernel.org/r/20261104-alpha-profileme-v6-0-63362e929=
0a3@gmail.com
> > > >
> > > > This series is the perf tool side. Patch 1 decodes the raw data in =
perf
> > > > report -D and perf script -D, as is done for AMD IBS. It copies the=
 new
> > > > uapi header from the kernel series into tools/arch, so it should wa=
it
> > > > until that header is merged. Patch 2 adds a script that sums the st=
atus
> > > > by symbol or by instruction, in the style of DCPI. Patch 3 gives pe=
rf
> > > > mem a ProfileMe event, as the kernel series reports the DTB hits an=
d
> > > > misses of loads and stores in the data source.
> > > >
> > > > To try it, with the kernel series applied:
> > > >
> > > >   perf record -R -e cpu/instructions,profileme/ -- ./workload
> > > >   tools/perf/python/alpha-profileme.py --pc
> > > >
> > > > I tested this on an AlphaServer ES47 (EV7). Sampling a loop whose
> > > > branch tests random data reports that branch mispredicted in 21% of=
 its
> > > > samples, and 0% with sorted data. As a normal user, perf mem record=
 on
> > > > a loop that loads one word from each page reports the load's DTB hi=
ts
> > > > and misses.
> > > >
> > > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > > ---
> > > > Changes in v4:
> > > > - Patches 1 and 2: ignore TRP, and MIS and the trap type with it, f=
or
> > > >   an instruction killed before it was mapped, as the kernel series
> > > >   does. Thanks to Ian Rogers.
> > > > - Patch 2: record cpu/instructions,profileme/ in the example, as a
> > > >   precise event now samples only retired instructions, which leaves
> > > >   the killed% and invalid% columns at 0. Thanks to Ian Rogers.
> > > > - New patch 3: add a perf mem event for Alpha, cpu/cycles,profileme=
/.
> > > >   Suggested by Ian Rogers.
> > > > - Link to v3: https://patch.msgid.link/20261102-perf-alpha-profilem=
e-v3-0-4bf6e1dda733@gmail.com
> > > >
> > > > Changes in v3:
> > > > - Patch 1: silence -Wpacked around the uapi header, which breaks th=
e
> > > >   build where __u64 is 4-byte aligned, such as sh4.
> > > > - Patch 2: only read raw data from cpu PMU events, as a tracepoint'=
s
> > > >   payload can pass for ProfileMe status. Thanks to Magnus Lindholm.
> > > > - Patch 2: print a table for each thing PCTR1 can count, so that mi=
xing
> > > >   events no longer averages unrelated values. Thanks to Magnus Lind=
holm.
> > > > - Link to v2: https://patch.msgid.link/20261030-perf-alpha-profilem=
e-v2-0-9ce2f0b0e622@gmail.com
> > > >
> > > > Changes in v2:
> > > > - Patch 1: copy the raw data out of the sample and convert it from
> > > >   little endian, so that it decodes on strict-alignment and big-end=
ian
> > > >   hosts.
> > > > - Patches 1 and 2: follow the new 28-byte struct alpha_profileme_sa=
mple
> > > >   from kernel v2.
> > > > - Link to v1: https://patch.msgid.link/20261028-perf-alpha-profilem=
e-v1-0-f46c1938d001@gmail.com
> > > >
> > > > ---
> > > > Matt Turner (3):
> > > >       perf alpha: Decode ProfileMe raw samples
> > > >       perf python: Add alpha-profileme.py
> > > >       perf alpha: Add perf mem support
> > > >
> > > >  tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
> > > >  tools/perf/Documentation/perf-mem.txt          |   3 +
> > > >  tools/perf/arch/alpha/Build                    |   2 +-
> > > >  tools/perf/arch/alpha/util/Build               |   2 +
> > > >  tools/perf/arch/alpha/util/mem-events.c        |  17 +++
> > > >  tools/perf/arch/alpha/util/mem-events.h        |   7 +
> > > >  tools/perf/arch/alpha/util/pmu.c               |  11 ++
> > > >  tools/perf/check-headers.sh                    |   1 +
> > > >  tools/perf/python/alpha-profileme.py           | 178 +++++++++++++=
++++++++++++
> > > >  tools/perf/util/Build                          |   1 +
> > > >  tools/perf/util/alpha-sample-raw.c             | 156 +++++++++++++=
+++++++++
> > > >  tools/perf/util/sample-raw.c                   |   2 +
> > > >  tools/perf/util/sample-raw.h                   |   2 +
> > > >  13 files changed, 412 insertions(+), 1 deletion(-)
> > > > ---
> > > > base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
> > > > change-id: 20261028-perf-alpha-profileme-8010299be323
> > > >
> > > > Best regards,
> > > > --
> > > > Matt Turner <mattst88@gmail.com>
> > > >
> > >
> > > My plan is to take this series through the Alpha tree alongside the
> > > kernel ProfileMe support. Does that work for the perf maintainers?
> > > An Acked-by would be appreciated.
> >
> > Should be ok as it hardly touches the common code.
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Ian, does it look ok to you?
> >
>
> Thanks for the ack. Taking this through the Alpha tree will keep
> the tools support together with the kernel changes it depends on.
> I'll add your Acked-by when applying the series to my for-next,
> pending any further comments from Ian.

Hi,

The v4 tools series looks very clean and addresses all the previous
points (masking TRP/MIS when killed, updated script examples, and the
perf mem arch support). Taking this through the Alpha tree alongside
the kernel series makes complete sense to me. I have some refactoring
patches sent out, but the alpha changes are small enough I don't
expect collisions.

For the series:
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Magnus
>
> > Thanks,
> > Namhyung
> >
