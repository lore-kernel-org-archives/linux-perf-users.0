Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177F70823;
	Tue, 24 Jun 2025 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730930; cv=none; b=uesaaDCcmsbNpqkwETFlulBfMpZ1PQMM/6K0HNzTT7FOO8pRyCSym9lLTySil+hkQLFTz+N2GytpAG1OQSMI4PIlQ2DuAgc5orh2mhzUPBD8y60c+XMLFtmQvNTfc8bN2yn6fea47CjkXygYCmwpzhE3AzKOix524AM0gTNA12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730930; c=relaxed/simple;
	bh=anYKDvR8DwDeM3aQ4PCChlVBnQFelZ2vGi13KfiM9E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QMF63Vcyrx2o+V4q6xIld8f/gY2cjf6SV/YH537Gzb6dmYISrjC68rdkh0NpR7Dnm/xRHcKEmo9+BChWSl95eLIKsSSO4K0nY1ru1ZZmAOdScBcL4DtGMH0hILuY9IKuc1gPq/W1rKLXYC3rOMgjlW/F+V0ZAMsTUUQr9+UwZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvI9+7VV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvI9+7VV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4496725b3a.3;
        Mon, 23 Jun 2025 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750730928; x=1751335728; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2oc+mgjMQNNWposKF3yskLOrCAbudsug2tB2/9g9MI=;
        b=YvI9+7VVW6M6HgLn3M651TizHWhC7E48s4barsv+yV4uw3MuyD9fMdqu3b5C4rPUlv
         3n1j8kN0KOjJxrjLhuh0vRHizTm6Tjfz0LsSq8GmTuVVC4b3tb8IAYyq/zuHRPnHjjQk
         w18mPP9iVDeVxmJd4Vkk+o5n/XX64bBPNwyg39u07iTbBem+gXA2IQ4oZin6JztdQBpg
         tXANKVNsJgZny4S3AOBmVI6dnn76/RSrO49q0wojYKaY0yH9RZkN/h/BHh3L9od3GLd5
         Nsp7ylNbH/u1kyoKKN7Qv0rFm4vhOgVXuaAHGvEQWwqQGgdFiWVnymgb+tMBQ2gwm/nM
         jVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750730928; x=1751335728;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2oc+mgjMQNNWposKF3yskLOrCAbudsug2tB2/9g9MI=;
        b=APxVSLHXyJ+N5rCY/J3dMBdU/CGgn9v00b8Wfk4l6zotKaIDpkXLoqC51jUycu/7r1
         3IhHJ/myYQJWX8vAcBEZMzM0OWjSzCPfrFkU2bruVkqC5Awv7YLzOz9KtZEdD97G8liT
         PJtJrxPnzAlaTW+z2AWmQdg6IaI7V8h/zuAiu9GqeHhxY7SxNx4Vap66eD0Eh6CaNgs1
         uWsCQ0a09AMBtVnuMZn9IgaeGt+J+8u6t6lYu7QBAHrRaFTcMXHV+y5Pg2QqDm88vHan
         6O0/bXccVOZXtNlHmUrrsTqBCBgw2U8IKNV2AxJDBoPmlYqdCtySg673ZPO2smC9Y6xZ
         cNcg==
X-Forwarded-Encrypted: i=1; AJvYcCUVwJovm0jaEH6d2Tr3llTgTIOSOfXNFsoK5XPbtWQi3DFmxPL4JJIn7v0Y22pbnuShpzGAK7SsB0++QVivKGfhqw==@vger.kernel.org, AJvYcCWYuN6DNKyvtP1FD7P6sIBOf4viK9SiWCiwf4efLlqlLd2u+MQOAeCTWCGyjq8WWzYFMV2mxxhd5wqHO6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGNEoRp9LXotEU42ShimPv+pmAFzvY2SWOSumLP0wIH34jNnU
	wHpyt8C8pbAL5wsF/QK8IFNG8h3W7G0yJ/HU9h+dfELyLburQttVOdZM
X-Gm-Gg: ASbGnct/vtdlfx0qnkcT1sPcChL2O9d5DE9KN+qKrhqlMwf6qjWLx3igQd3Tr5UPBoU
	YCMSPZWbeXNQ52IXBeeLkX6Q0ACWHXiqdCXnAlqPzeirELVOMmh6AtNQuvJBNFU7FRte7pxnK+r
	/jangnUYG9J2SInVFLGYvurm6eZAXDmaS8eJPX07Zov5GIQWr1+SO0UH5nj+lQqSw8mMQ8h6/zk
	G3ntXz/BpUMSHEMwBl2RMxE8oPCW03TTuAhdYJUV9WdL9pbYIclxM1UaqPfn4Nkc88L0CMcI37f
	91IbKyUguuCUqy1SmCJ0v6D06DIKsar1bWECLAm4mnB0eAfr4wbMmA==
X-Google-Smtp-Source: AGHT+IFGIbUi2Qy/t4xYSIJgfyKkG4kE3SiKWwQkArqWcKBMn2Mq2xL6jkLM1ee/rlXdhBn05A7iMg==
X-Received: by 2002:a05:6a21:3949:b0:215:eafc:abda with SMTP id adf61e73a8af0-22026dd5607mr25340535637.18.1750730927811;
        Mon, 23 Jun 2025 19:08:47 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::1707])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c887261esm440237b3a.156.2025.06.23.19.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:08:47 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@redhat.com>,  Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>,  Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Adrian Hunter <adrian.hunter@intel.com>,  "Liang,
 Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash
 dialect.
In-Reply-To: <CAP-5=fVoya-X+BBBuVwZQ527WKyGwC8tirk=gj37t2H_BBmwVg@mail.gmail.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
	<20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org>
	<874iwa71mo.fsf@gmail.com>
	<6f524405-a9a7-45c4-bf4d-9ae33e52bfbc@linaro.org>
	<CAP-5=fVoya-X+BBBuVwZQ527WKyGwC8tirk=gj37t2H_BBmwVg@mail.gmail.com>
Date: Mon, 23 Jun 2025 19:08:46 -0700
Message-ID: <875xglj3gx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ian,

Ian Rogers <irogers@google.com> writes:

>> > $ find tools/perf -name Build | xargs grep bash
>> > tools/perf/Build:     $(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>> > tools/perf/trace/beauty/Build:        $(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
>> >
>> > Collin
>>
>> In that case:
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>>
>> And I'll send the bulk hashbang change separately.
>
> I've no objection to switching to using bash globally. It seems
> sub-optimal that we've copy-pasted the shellcheck command across many
> different Build files and that this patch will cause the
> tools/perf/tests/Build one to differ. My preference would be to have a
> global definition probably in Makefile.perf, then use it consistently.
> Alternative all shellcheck invocations can pass "-s bash" for the sake
> of consistency.  Fwiw, I think the 'tools/arch/x86/tools/gen-insn-*'
> which is to some extent taken from the kernel's 'arch/x86/tools' is
> okay with the change too.

Good point. It turns out there was a SHELLCHECK variable in
Makefile.perf, but it was not used consistently.

I have submitted V2 that adds the '-s bash' option to the definition and
actually uses the variable [1]

Collin

[1] https://lore.kernel.org/all/f7ea3a430dc2bd77656c50f93283547d1245e2fe.1750730589.git.collin.funk1@gmail.com/
