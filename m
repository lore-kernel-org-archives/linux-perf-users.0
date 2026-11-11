Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392186;
	b=GeJEYloU1r5rk2xw+H/EDc+sfaClri9Z+/c0DS5RTevVokX9QhUff2I5Iv4/AhZSd5qy
	 w3iWuH8neizBXR+BIKvVA2EzlljMAb9LlcT9pomgfj8K7wgUr0LHQGqiah6au8MywcOtq
	 dPznUd+eGl+0t+u4btD5XqcU6ydTaV+FABKRFXS0qKpTVENlAXgpOr6XLlO30rsy7rv++
	 VBTKrTCdxdC5pv8qW6rC3a/Dr9i66FztRu0DJYwAalaPyMRNWSM0FTITty4yZ9EL+ctL4
	 CC7V/3N/NZ7qZmR89WR8sZzay4Iu7TAdSBEbKTgPWlLx4i5aoNxVv8IWbKhMB9ExDsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=PvjHD5xBoQ0K8cdpA5aBSTc2W83sPTGK/ro8kbHtLgQ=;
	b=oxRffkrFUFDzbDwQQLJkz5JCubQV8BL/svdehU4kywKNc9kQTyZ4YrPIoxrcsVOwjCEy
	 xm7bh8ngbuEldVn6XfFEGvaB/RpCyu54hwPJIIf65x9sMgvaJLaUwpJGSMgCM8lEMKFjS
	 y+l1745fwsdaUr5Daag/S1g7MJ+6BV0SKaCT48tobMOTkpHFj8n9U/GZdQ2T18xRNLXRT
	 WCXm+34lrb2sv0JmSy9SUSbBHLaluDWSgLWnvPPGLopdQGjcGuabT680lMoSdsRJAOrYn
	 +VNlYRWz8BTGDfH9fd6XEdJuJ1/1qksu1w7MfpTA1P5seq8p+9sBTFTsaXhiDibWzPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="l8/uvvXQ";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD62606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 10:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD62606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l8/uvvXQ
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49465892f7bso2170319f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794392184; x=1794996984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PvjHD5xBoQ0K8cdpA5aBSTc2W83sPTGK/ro8kbHtLgQ=;
        b=l8/uvvXQyUpDwc2GLjrDT1bnuyDZE6FuDzWdb2uwISwSZ5EyLuDoHo/dPhB2W+b+Sm
         M9u/hR1EcnrqKuaMpXUEV7wKcx5m4bc6f7YwVZCXeEbRjVH1QkXKeUjAVMphw/FkAu2J
         VG5aIqboFM1lzT6dAEh+pgKraaSY78EmvqhioAwrkJ4wk4S30tplLN9qR455UG6Npxau
         gkejjbHdehkSB9tftfuUQeaj7tkGV7dtFDL4xx49Ep1xzmokz1EsYoB//4DPsrZ9GkZS
         dKoSr01miwOl4cCPd3nXTpReSmcIz3FcvzTWuteIecTP1tEvG4lvViRDIOeL0BmBqKOo
         aLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392184; x=1794996984;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvjHD5xBoQ0K8cdpA5aBSTc2W83sPTGK/ro8kbHtLgQ=;
        b=hZ1h0gDAVn5hWP86yg62htjidzC4rtMY+bg/0XL+41WA+K0ACwcgj9/BMHj2+8Bpp5
         qwEBIeYkXlhPy6Lthy1+s1dXku7x3uslBluK+LSbFBl1pKxVZDEjti6lTexjD4MhBR21
         B98Ka1ALgA8GLDtzxdqqtLm0w/u0NhVui4VQ8zmaMok7uBb8oP+LljjGlZZ4/ytEjtUd
         gTu1U2ASmuok2u9G7D4SleFLw2S52ubLl6F4inQ4yUrJIkVa8Gs6/ttEe3hyT+5HFIv8
         iVyukgPsO7cZYEzAo0zKfyVzUF07m1/xIFzC4ZTaRcbT+4KTg/Ysl3U3UspbP2/Rl1YU
         BZEg==
X-Gm-Message-State: APuU4Z9UvYAl/qGgcByyOgC+0a7kwpCVo8VgujhZD9Or+lLRjWW/wkI+
	bY4OwRi27bP4ehtQS5M5LH7uUxR3OEWKGaOF7eHhGSXe2aAHywIVa0YTK8zBOeTAorQ=
X-Gm-Gg: AYBFou3fVjKnbdKLBOclm3k96pm7CVlOCdG3g4yvkuIN8LNzYJzjbKtAGx6EfWztyk2
	Qjkn6IHtVDLmK2429uQ0SEHwa6RH+vJXO4Hcz2PcbCigtnTOKSJqTO+F2GaI1dWqd0AnxA30xak
	anrGkzh6sVIXw8fH018XyYazb0zv37YlW+Qne1mI9kBaCb00AdtiTuC1v3dWTwewWPadskZMQpN
	0ZzSMRtR6yFvdTIBrrGCHsoImeVAg0+uz6S92+SfKpZtfFyJMnbtRBhmng1T5QGmLTdXT6XAoy7
	5kFHdRMfUE9TPe5QXp0ZoQjGh4T6xnajfQWfY8MhL13B1xTeRIfHlCBUSIVNsaXcpSgr8h55JMP
	99romrY4fIW+7gUpnwbamkx0MoUP4NTbQGGKwBWDtnug6627zMofNva7JGE8IcAjczC0MHkD7kH
	o07DnYNHsYf43wi33KObsyVvVH/x0pcrsbMUYdz2Bi/fDew9TdgLtteboni2gfLMqgLMoftuyEn
	/aCgrjro9EwOJoqtmpNVzaSxjr+2yx5V5q2X+/UTDSq4QN2bjqFnuMB/Ixp9aMvzl67H0selS8P
	SYyz3nOXJh0dvQoFJGNzP86QOV7fCXLsvfHMZlLrfKARONxzKAXTLaw=
X-Received: by 2002:a05:6000:288f:b0:48d:ff06:c626 with SMTP id ffacd0b85a97d-499c6cac56dmr3026544f8f.35.1794392184151;
        Wed, 11 Nov 2026 02:16:24 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c2793sm10054961f8f.45.2026.11.11.02.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 02:16:23 -0800 (PST)
Message-ID: <39ac224f-2903-496e-9a08-b4c5a33dc87f@linaro.org>
Date: Wed, 11 Nov 2026 10:16:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled
 PublicDescription keys
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.garry@linux.dev>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261108183846.3804875-1-takano32@gmail.com>
 <bf6925f6-613f-4e20-8491-2a99183f34fb@linaro.org>
 <179433972506.1746408.6665119010100304383@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <179433972506.1746408.6665119010100304383@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/11/2026 19:42, TAKANO Mitsuhiro wrote:
> On 2026-11-09 10:24, James Clark wrote:
> 
>> Shouldn't jevents enforce some kind of schema? This seems like a bug in
>> the generator that it's allowed. And we have all the json files in one
>> repo, so we can fix everything when adding strict validation.
> 
> You are right, and there is a patch for it now:
> 
> https://lore.kernel.org/linux-perf-users/20261110193239.1741014-1-takano32@gmail.com/
> 
> It is not a schema, and I don't think it should be one yet.  It checks
> nothing about types, required fields or value ranges.  It reports the keys
> that jevents.py never asks for, when the spelling is a near miss for a

IMO I would rather have something that's incredibly strict and simple, 
or nothing at all. Having to work around edge cases and report near 
misses doesn't sound great.

> name it does ask for.  The failure here is that "PublicDescrition" was
> never read, so the field was dead in 16 objects and nothing in the build or
> in the tables said so.  What makes it cost something is the AMD tables:
> "BriefDescript6ion" is the only description those three objects have, so
> the generated table carries an empty text field for ls_inef_sw_pref.all on
> Zen 4, Zen 5 and Zen 6.  In your table the output is unchanged, because the
> value repeats BriefDescription and jevents.py drops the long description
> when the two are equal - which is exactly why the typo could sit there
> unnoticed.
> 
> I did not go the schema route because a table may legitimately carry a
> field for another reader: the Intel tables carry Counter, CountersNumFixed,
> CountersNumGeneric and Experimental, none of which jevents.py reads, and
> Experimental is read by metric.py.  A schema, or an allow list inside

But we can have a schema for json files that are checked into 
tools/perf/pmu-events/arch/ regardless of who reads them. The schema can 
say that "Counter" is valid as long as we agree that it's ok for that 
field to exist, even if jevents.py doesn't read it.

Then it's as simple as:

   from jsonschema import validate
   for path in Path(pmu-data).rglob("*.json"):
     validate(json.loads(path.read_text()), schema)

Where 'schema' is something like:

   schema = {
     "type": "array",
     "items": {
         "type": "object",
         "required": ["EventCode", "EventName", "BriefDescription"],
     ...

> jevents.py, would mean asking every vendor that adds such a field to edit
> perf's Python first.  So the set of names jevents.py reads is the only
> list, and a key below the similarity cutoff is left alone.  It will not
> catch everything -- a key that is a word of its own, or a misspelling that
> lands on another existing key, gets through -- which is why I would rather
> not present it as validation.
> 
> It reads the whole tree, not just the architecture being built: the typo is
> cheapest to fix by whoever reads that table next, and that person may be
> building something else -- this arm64 one shows up in a run over the whole
> tree from an x86 box.  The exit status is 0 for a clean tree, 1 when
> something was reported and 2 when a table could not be read.  make turns
> both failures into its own status, so a script that has to tell them apart
> should run pmu-events/jevents.py directly; for a person it is
> 
>    make -C tools/perf jevents-check
> 
> which reads the whole tree, and JEVENTS_CHECK_ARCH=x86 reads x86 plus the
> common and test tables every build reads.  I kept it out of `make check`,
> which is the sparse run over the C sources and needs a configured tree and a
> C parser, and out of perf test as well: tests/pmu-events.c compares what it
> generates from testarch/testcpu against a fixed list, and a key jevents.py
> never read leaves no trace in the generated C, so a runtime test has
> nothing to assert on.
> 
> It is not wired into the build: I had a version that ran it from
> pmu-events/Build on every build and dropped it, because a report about a
> table this build does not use would fail the build for everyone.  It costs
> nothing when it does not run, since the tracking that makes a report
> possible is switched off unless the check asked for it.
> 
> The two misspellings it finds were posted separately: the arm64 one is
> this thread, the AMD one is
> 
> https://lore.kernel.org/linux-perf-users/20261108184600.3810059-1-takano32@gmail.com/
> 
> The generated tables are byte for byte the same as before on x86, arm64 and
> the whole tree.
> 
> Written with Hermes Agent, an LLM assistant; the author reviewed it and ran
> the checks it describes.
> 

