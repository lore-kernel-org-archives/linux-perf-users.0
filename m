Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339729;
	b=nSsyQDrSA6pXM8aZttyaLe/yb3qdjesRjnh5Tfd/oScdSsERrKcc+7lzr4240/DG6JnN
	 HMZAIXR1NFRL3pFWN5Ucs8peeDM5tHhIx3RigDCXXO+I7Lr+GlctVV8/iPO4Ap4vOgckc
	 q7/JjblJihVgVlwfF13ICP3Sxkj2BEQP3LXmJ8iqLs4tQGVqcLXSYKweYosjBbdiX1ePN
	 SNm5GyZFiB9hcTQsggbqTK1Uh9Ni82rAKXhhIGADFz0fGI3Kog3IIT/+Px3qiNH3ajf2h
	 5Jjhv0UXfNFehhFLuyscWug9/zQzIaIxvRVW8unwrToKHOhomIotuSKVOU7tGgWoDlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=q5qW6t9RZikzPsIz5xM6Y9f/cfbt15VH92CdwgczBFw=;
	b=HLd7iCh+gdENsgU6khIoUnTyW4k7bfs9S/UXveaz1d/T4diUzey+ETh3aA0KbqAlTRk6
	 oERV878uS7IQPVGkGLmYilanjbqGVq5gA/LlMbakLGCf0F2LootPI9uM0u2eJuB6oWMjH
	 hNIPzdMp4oXtLFIgAqFRDDP3w2junL9vQhRsEhEoE74VEY7/1rhjAiBUsCdbcpvE13D58
	 IHcfe6Q/bSb0vEDZXEYjZg9RS3hnZJnT9xTHyURlfXhVhkfyhOHTxif/uBsxYchnMSUd7
	 M6uQms4znTkbCAMEAzg0wXbueL2I/sd8RwKU9MYxT8WVD0YZ8/2YpourIULf8TGh1HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QdwKINgO;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A9606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F5A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QdwKINgO
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so4796716eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794339728; x=1794944528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5qW6t9RZikzPsIz5xM6Y9f/cfbt15VH92CdwgczBFw=;
        b=QdwKINgO26+AT5G1BOe6L+l96FPmurClB9BtT6GXQebLarbJMGudGwiE/pCrUD6HSv
         j/0fXcYQuBkSnfidBHp0U7tMIwc+cZtcEmGzugGm9xw5TA38ULz/nM/elpuTNuZZCq21
         /hp9b+oogZ9L+i6gHqJr1P7e9TezbiXnrzKtkxZWUSmprx8klnevjlecOoO0ZplLSENO
         kS3B6K47cHNpdMkkXYxvAOTpTvGDsR9htvc6fIiY7FKkr31DcfV8Dyswanj97H9uyEI4
         uayaM4R4g/eVN1eM6vATyOSvMHM5OlX4zhRd/OHem+5y1uBiXm4696G7zJv3aX+LgW0d
         9mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794339728; x=1794944528;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5qW6t9RZikzPsIz5xM6Y9f/cfbt15VH92CdwgczBFw=;
        b=gNtapckoiQIq3cyCwO346S+lRVe39MxtTcUzc1I7dV7O2dBGbU8HU4CoOE2dKFApH1
         jvniDXQJrupzxU2H/oaGNWMbf+WErX6eEaM5c2lKvFX4Tcz7i2n8PR0rcMOvny1DgzyA
         RCKpEhxSRVv/FVyGoqicEK7VDPG5Q4fm34ivh9NHaQvtkIHBApBIn9O8NHy+pL6rINzT
         VamW9Hn9RzvhUAGD73BHitJsWdJfwwfPaUQhYA9HcptjGFIyD7StVXV+qVE56l0/8UK8
         tsVeRI8nnFs3LirSv7Wgrs2+hvASQ5odv67sZGEgo2p6JqP5sH6+pVkQvVCB3ncTZn2g
         K/6w==
X-Gm-Message-State: APuU4Z9cyzam7JtpSbD9fW2yf+cjEZtfR8KLS0IuFHrRdV4xmYmzFBRq
	NWOCccjusG46jS4bfzBC64eBz0E8cFy3J0dtFVDBCuZZUw0y2nZw5MpMpKF4QA==
X-Gm-Gg: AYBFou0q7jgBU1QTH47FE2rot8CA1LkMPA3hvs3Fb6m5AII4eXmRIUs5cw5SPubMEBj
	Yh4soDJFyMhzBCEohf0JML+fUAbokUzH40iPIa3gbwwuZtJCAgjdF8Tczb7lJWczCGkZSk8zafk
	4wHZva3lpWOd/ZZBkdc/qvOWCUf4/VnyEtlFVMEK55JE2VmOS8ICWjne50nLhlFh7/vTu912R/3
	+CgvUf4OFVrrs4sG5lgh8+rqOUPNq9pOLzIlA4aqsKiZocdpyoljsYKJ9UtwAE6R9x60t1KGgOo
	6SdTyOsK2UC61NAzGFaOZyt38E2Rm6aaJCUI5s3kY3hcf4YyatvmS2C9H/EK9lY7bBkycbNUhy6
	qsbo3RPp1/axbBgkV3XP0ES17nOJ2nKJVUV3AeWQNRCtt2xzMTT81LDbzGrIkQli9bUEvQU+x3c
	tFxmfof5IhqxD/6qIgodsInD7eFzxBUcuYNdGkdgiKCDxAZksfaIQNHc/fB+S1HVuUQNV9f4gVQ
	D9zU4YYZ/J1birS5iI0YgIIuTuDQ0qVlUFrf+OueG6lJOcBA2MNUQm1rjJOZfIgG8+ZP4IbvoHG
	5fdXTguYQgMVkCWEuGNjQTVIng==
X-Received: by 2002:a05:693c:62d0:b0:36e:535c:60b4 with SMTP id 5a478bee46e88-37685c7a5a3mr308597eec.13.1794339727953;
        Tue, 10 Nov 2026 11:42:07 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm7825076eec.4.2026.11.10.11.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:42:07 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled PublicDescription keys
Date: Tue, 10 Nov 2026 19:42:05 +0000
Message-ID: <179433972506.1746408.6665119010100304383@gmail.com>
In-Reply-To: <bf6925f6-613f-4e20-8491-2a99183f34fb@linaro.org>
References: <20261108183846.3804875-1-takano32@gmail.com> <bf6925f6-613f-4e20-8491-2a99183f34fb@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

On 2026-11-09 10:24, James Clark wrote:

> Shouldn't jevents enforce some kind of schema? This seems like a bug in
> the generator that it's allowed. And we have all the json files in one
> repo, so we can fix everything when adding strict validation.

You are right, and there is a patch for it now:

https://lore.kernel.org/linux-perf-users/20261110193239.1741014-1-takano32@gmail.com/

It is not a schema, and I don't think it should be one yet.  It checks
nothing about types, required fields or value ranges.  It reports the keys
that jevents.py never asks for, when the spelling is a near miss for a
name it does ask for.  The failure here is that "PublicDescrition" was
never read, so the field was dead in 16 objects and nothing in the build or
in the tables said so.  What makes it cost something is the AMD tables:
"BriefDescript6ion" is the only description those three objects have, so
the generated table carries an empty text field for ls_inef_sw_pref.all on
Zen 4, Zen 5 and Zen 6.  In your table the output is unchanged, because the
value repeats BriefDescription and jevents.py drops the long description
when the two are equal - which is exactly why the typo could sit there
unnoticed.

I did not go the schema route because a table may legitimately carry a
field for another reader: the Intel tables carry Counter, CountersNumFixed,
CountersNumGeneric and Experimental, none of which jevents.py reads, and
Experimental is read by metric.py.  A schema, or an allow list inside
jevents.py, would mean asking every vendor that adds such a field to edit
perf's Python first.  So the set of names jevents.py reads is the only
list, and a key below the similarity cutoff is left alone.  It will not
catch everything -- a key that is a word of its own, or a misspelling that
lands on another existing key, gets through -- which is why I would rather
not present it as validation.

It reads the whole tree, not just the architecture being built: the typo is
cheapest to fix by whoever reads that table next, and that person may be
building something else -- this arm64 one shows up in a run over the whole
tree from an x86 box.  The exit status is 0 for a clean tree, 1 when
something was reported and 2 when a table could not be read.  make turns
both failures into its own status, so a script that has to tell them apart
should run pmu-events/jevents.py directly; for a person it is

  make -C tools/perf jevents-check

which reads the whole tree, and JEVENTS_CHECK_ARCH=x86 reads x86 plus the
common and test tables every build reads.  I kept it out of `make check`,
which is the sparse run over the C sources and needs a configured tree and a
C parser, and out of perf test as well: tests/pmu-events.c compares what it
generates from testarch/testcpu against a fixed list, and a key jevents.py
never read leaves no trace in the generated C, so a runtime test has
nothing to assert on.

It is not wired into the build: I had a version that ran it from
pmu-events/Build on every build and dropped it, because a report about a
table this build does not use would fail the build for everyone.  It costs
nothing when it does not run, since the tracking that makes a report
possible is switched off unless the check asked for it.

The two misspellings it finds were posted separately: the arm64 one is
this thread, the AMD one is

https://lore.kernel.org/linux-perf-users/20261108184600.3810059-1-takano32@gmail.com/

The generated tables are byte for byte the same as before on x86, arm64 and
the whole tree.

Written with Hermes Agent, an LLM assistant; the author reviewed it and ran
the checks it describes.

