Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB6C13D;
	Tue, 27 Aug 2024 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737769; cv=none; b=ci/3hBvYkLi03Ty4o4lPq5isxIPW29nZx7SxBdr6xo33gql/AihoJ23fSzKLeQ578oUIQuB6fl471rYkKkvQznJnnMc6vMOn5T58Bhj8HF+mRVY4jZtan4NSV2pAboKJ62//n5x90zC/0Efk2ggmV7mvN4i2HyWDdE0y0pnnw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737769; c=relaxed/simple;
	bh=H71/aYAXqYJwAN8sgbtfV+aIuHl/VGuoiUnucCnLxJE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a3LmPjXZt3np+EtANExgL/fWL913Vs/UOiVsRo4nUWTxpUqq3516ZbHMLZIB3Imi23d1xawg2nhe8ejHldWAgJ+Q/pNPYYQ+1XRHZARdju8oOlsVcwaTAPmWUcfwmJezgyboSwYyqWB3e+vuFC0BYXXCVzT7cBJNAggao+3U/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEzUS56v; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEzUS56v"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3c99c5d69so571138a91.1;
        Mon, 26 Aug 2024 22:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724737767; x=1725342567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlV3mNALClF5Ml0OpbfhYTioIXZRLuIAswgGkI4NLF8=;
        b=ZEzUS56vrY6Uzwk/QhQvL8v+koc7a0erKxsLOe9OhGNL9MF9aWKsGy3vJejTNV9lU4
         FoXMKYZvhWFWXHgm3kxpPj63YnSuwcwAO5BcUyHXqg+1p7TB1DEuD1sFrUJP3NNUahJl
         OfvHR0+dVlaOPdJ0N/o+2pqDIQR9w65LAVscWhJcjsLsDl4I8p2viPpRa82w8MlVgTRz
         y/HM3pMXyll6pxUzpadwoAlmecX8OiE/AR2uy1CYTyv3QtMK7Qo81/jnje0LBoDRx64u
         QidyspwMHQb9DTPp17SHl6iH4rYTnFW36H8sqoJdV295EVTpv53ap2v+y9PSTsVJtEEa
         9i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724737767; x=1725342567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlV3mNALClF5Ml0OpbfhYTioIXZRLuIAswgGkI4NLF8=;
        b=DdQObydYVVVGe7Li0DoJFzNVOKMo05i1FDZ8Yhqpn9WYWNwt8SE33LguJ5N2Ql1lKH
         OcYLKf3pvWjTzvZ3bCFzGJGWQw6Tg1eTPrFkmE1CcYbs3n794gh46Nn6egqMnPV/YiUV
         xtJxU88B74u5wEzg5mS6L40o3U36X2Fl53B07dg+vmdAtBIc0sDfeT1we4zQJtINzMCt
         BhIroPbkDo4VLOUC+YPdj0TCPGm9PQIBeCNksLKlXEe6rhVYL72wnjvhOh756MHdnahh
         2m0M+EQ1dt46YKRhKY5re60RvXoBDg8t+pkN0R+/7zy1QRSrQ/4gWpt935D4D8WkCACr
         x8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVaB9pCJYKwZFo8yiJTFqfGF88lb2y5ykdMGmcrS+wEoCqhdftZTFv8aslrGWv524bKvQ37Sf4GwHX6MwLvz4YfmQ==@vger.kernel.org, AJvYcCWCSfn654QyxqrlBoNiswLUZl7vgUTJR1Np9+u3Dx8VPViv67Y2g+E7Im+YJehKIaf9WmpzHHX3YBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1b2vyUwhnq0wDj4CXAptPTAVljki65co2qTZx6wZJRKyVh7A
	gCnVcclXEW6exh+zL3EPy08hxf7UJFxTpNHDL5A8ch/fLIJMs1z4
X-Google-Smtp-Source: AGHT+IGfucX9mDgUrzuySTCskPK0kKV/1nkYr22Dy0uEMx1ge1Jh/riVvE/aoiayy+EYt3LC7FNegQ==
X-Received: by 2002:a05:6a20:4329:b0:1c4:92fc:7c79 with SMTP id adf61e73a8af0-1cc89ed9494mr9798523637.5.1724737767113;
        Mon, 26 Aug 2024 22:49:27 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203856099c9sm75766165ad.210.2024.08.26.22.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 22:49:26 -0700 (PDT)
Message-ID: <aed2411c-fd24-43e6-9094-9247513b1915@gmail.com>
Date: Tue, 27 Aug 2024 14:49:23 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yunseong Kim <yskelg@gmail.com>
Subject: Re: publish: perfwiki.github.io
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 linux-doc@vger.kernel.org, Austin Kim <austindh.kim@gmail.com>,
 MichelleJin <shjy180909@gmail.com>, Yeoreum Yun <ppbuk5246@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>, Gichoel Choi <gichoel3101@gmail.com>
References: <7f2b1c74-4087-4da4-94eb-51d37f3d8fc2@gmail.com>
 <CAP-5=fVmP0sNaE-T0PAHb0y+Eoo7eNgDFyu7kCT+Hp+G62KXHw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fVmP0sNaE-T0PAHb0y+Eoo7eNgDFyu7kCT+Hp+G62KXHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ian,

On 8/25/24 2:06 오후, Ian Rogers wrote:
> On Fri, Aug 9, 2024 at 10:11 PM Yunseong Kim <yskelg@gmail.com> wrote:

>> Link: https://perfwiki.github.io/main/
> 
> I think this is great Yunseong, thank you for doing it! Sorry for not
> seeing your email earlier!

Thank you so much for your encouragement. I was truly happy to receive your reply.
Namhyung also offered a lot of encouragement through discord. :)

I also appreciate you taking the time to read through my lengthy mail.

I've currently added Namhyung, Ian, and Arnaldo as owners on perfwiki Github.
Feel free to update the perfwiki markdown contents whenever it’s convenient for you.

> Can you explain a little on how to create updates to the pages? For
> example, I see the topdown markdown here:
> https://github.com/perfwiki/main/blob/main/docs/top-down-analysis.md

I'm open to receiving contributions via GitHub Pull Requests
Link: https://github.com/perfwiki/main/pulls

Similarly, if someone have any discussions or requests, anyone can leave them as issues
Link: https://github.com/perfwiki/main/issues
or contact me via email.

I’ve written a guide on this topic in the README.md file.
Link: https://github.com/perfwiki/main?tab=readme-ov-file#automated-deployment-from-markdown

> It looks like if I update the markdown, in a fork, I then need to
> generate the HTML:
> https://github.com/perfwiki/main/blob/main/site/top-down-analysis/index.html
> Presumably I send a pull request containing the HTML and the mark down?
I took some time to review the deployment process for MkDocs.
Link: https://www.mkdocs.org/user-guide/deploying-your-docs/#project-pages

The branch used for deploying to the actual website is this one: "gh-pages" branch.
Link: https://github.com/perfwiki/main/tree/gh-pages

You can make changes to the markdown files in "main" branch directly.
I’ve already deleted the site directory from the main branch where I
previously made an incorrect push.

>> I noticed from the perf mailing list that there were issues with
>> logging in, and it seems the door lock is still broken with no sign
>> of it being fixed. This motivated me to start this migration.
> 
> Log in problems to the wiki have definitely been an issue. I think
> using github is a sensible way to resolve this.

Thank you for your feedback. Once the mirroring to GitLab is set up as planned,
it will be even better, as anyone will be able to access the repository even
if GitHub is down. :)

>> I wasn’t sure how long we’d have to wait to regain login access.
>> I hope you see this in a positive work and not as an act of rebellion
>> against using the original wiki. I genuinely believe this was the
>> best action I could take.
>>
>> This situation also made me wonder: Is it really a good idea for a
>> wiki, which is linked to the kernel and serves as an official
>> reference, to be updated without review from others through the
>> mailing list?
>>
>> While it might be convenient, during the migration,
>> I found quite a few documents that were linked for future additions
>> but never actually created.
> 
> Agreed, the wiki has been a work in progress for a long time. It is
> quite sad the corners haven't been filled out and the documentation
> that is there slowly bitrots.

Yes, as you mentioned, I will make the issue entries I identified during this
migration as issues so that others can be informed as well.

>> With a review process through the
>> mailing list, I believe the documentation could have been more
>> systematically organized.
>>
>> One thing we need to check is the licensing of the original wiki
>> content. The existing documents do not clearly specify their licenses.
> 
> Agreed. Are there examples we can learn from? For example, libbpf is
> active on github:
> https://github.com/libbpf/libbpf

Thank you Ian for providing the reference information. It would be great
to have a guide with improved accessibility and easily accessible questions,
similar to "libbpf" project. Going forward, when issues arise, I plan to refer
to how popular opensource projects label issues for open source contributors.

> Agreed. The perf documentation itself, largely the man pages, is a
> fork from the git source code 15 years ago. I did a round of deleting
> documentation that related to git and not to perf. I'm not sure how
> you'd propose packaging the documentation if it were part of the perf
> tool. I believe the thought in the wiki was to remove the burden that
> exists sending things to LKML. It is also for the best that the build
> not have external dependencies (such as downloading files) and is
> reproducible. An issue with the man pages was that they defaulted to
> placing the current date in them, I modified this so that we use the
> git last modified date and it thereby made builds reproducible.
> 
> Thanks,
> Ian

You're right. I completely agree. It's definitely best to avoid external dependencies.
Currently, there’s no specific packaging plan, and I’m just planning to link to the perf man
documentation in the kernel repository for now.

If you think there’s anything else I should work on or if I missed something, please let me know.

Thank you for taking the time to read my long email.

Please feel free to reach out anytime.

Best regards,
Yunseong Kim

