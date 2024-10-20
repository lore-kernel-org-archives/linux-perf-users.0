Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05827489
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Oct 2024 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729399759; cv=none; b=gFD67li5Jv4VnY16XzJFtgdTeFYdhW0AsDrI3roim1z1mwCdt3vGeECnJyEFI/2YE0/thWHQXF8VgB3v8LtVIsIBDsP3tl40rAEjP4uH/ziN11F8HNJKPkJ1a5WvmFc9qCd+IOytd9+mta4HTifUf2vJAilemKf/yqKpw46ce7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729399759; c=relaxed/simple;
	bh=V8/CaGwAkgVPFQvx0e5tswgosaeMMXzjSs6/ap5B71c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKDA3aQ0sWTAnkPsLeCjFy0MpFr33Zg+h1uKcxk2wGVhhWKnWganJip/3xbCgsAvlx8EtoQ3aW71mfmbzmaWizmC8pCLWjVw4EqMggJH0kCGKYtjasDUCRDffy1udaQ8pWuHaabCOsfIxj3A8Xll8/e5GRXNhPxvaqSbVxC+uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgurAk8b; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgurAk8b"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2af4dca5cso667142a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Oct 2024 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729399757; x=1730004557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmzlUejJoflLf1VpmPq1KtW89kLT4qtL3i9eLCSeR/Y=;
        b=PgurAk8bsMcuLyWZiPfi+feJWAUKbCMo1hxEKuCRvrEB9qG+eKMywwAOgOhxUIMd+x
         iCKfGn907sTbIsebE7Sx9HMpeDJQva6tK0JS7ZpwJgiKK2CvR6qIJrLE/G9AkzZWx4ni
         xZtR52Nxi+znjo+GoegZRWB41Ul7ofE2ICm+CHgMcTi4/Qvn2eUQv1QJ5NjHYnJe4Lgb
         65tPpZ28OUYOB/lCDBUwZ9yTeoL9gBKX8mq9lWuvIOx4IlDDhVXx7odu2m1ESn5ZQWz2
         Pb7gm5kPAPOedySi2ueOiGpcc/jmsO+5JZXmk7ImiJwTiwZH894Y/iygkJPMvQ+fg+fW
         eIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729399757; x=1730004557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmzlUejJoflLf1VpmPq1KtW89kLT4qtL3i9eLCSeR/Y=;
        b=SWnQ8qFwpKZA0gfb017GphCJYTUuGLuX7Z+bI3Wfi95/bQ4KwU43YepqVeEh6SCm0W
         hzrqAG1Q0Ld1teh4BWkrQYFDW7VnhgmhZ0BewDIp4G5xud9vrPEobpTegugoPCvE8fGF
         tAzrmpW/iVjelPqUYST6rQT4Dchx25r2XIzmoQ50NGCmpk57vJHKR9NRP8P1GDqX0Mbi
         6URJzvvLypf6Ggprn5lviYsbsqPDglOPillgZkxihLh7VudRKDayQOBxwDCd5SWMYMMH
         TPYOapcB21nZ2/UO/Joiiyf/u5T9AW/plI1pvldDWSGr3E3SiKvNiWm7Ik52JFVxbu17
         eLbw==
X-Forwarded-Encrypted: i=1; AJvYcCV0G8882R/8NchVKdl/p+zYpfmdB21Mz3ntiIuOg3zKDKBH9XdkPY50bWs8cprtUDQdyFJL42EaRsg3qX/EU+1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzqe5ajuCZUjQn1vjVVFz2IUNZdPIAIM83/eKAGPzhvx8U9y0Q
	kioMZfJ+c+4GuVlPKOl2uiCPfNvOTJc/BYzIdBWdL6kMhKkptt5L
X-Google-Smtp-Source: AGHT+IGKsqx9/8S5ymWC7MPxmDaR/rf4ymjZrVfSVXqme+2N/aioRpL0HsdA4pzhgSzmibhVA37Udw==
X-Received: by 2002:a05:6a00:2e24:b0:71e:66bb:d33b with SMTP id d2e1a72fcca58-71ea3129093mr4576476b3a.1.1729399756634;
        Sat, 19 Oct 2024 21:49:16 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec14159dfsm524019b3a.197.2024.10.19.21.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 21:49:16 -0700 (PDT)
Message-ID: <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
Date: Sun, 20 Oct 2024 13:49:11 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 linux-perf-users@vger.kernel.org, Howard Chu <howardchu95@gmail.com>,
 MichelleJin <shjy180909@gmail.com>, Austin Kim <austindh.kim@gmail.com>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi 

I would like to express my sincere gratitude to everyone for their help in the
official renewal of the perf wiki.

Additionally, the reason I chose to use Markdown is that I wanted to actively
utilize its media features. For example, I wanted to embed videos,
presentation slide or display Mermaid diagrams directly on the page.
I thought these features would be welcomed by users who are new to perf tools.

On 10/19/24 8:47 오전, Ian Rogers wrote:
> On Tue, Oct 15, 2024 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello Konstantin,
>>
>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
>>>>> Yunseong created:
>>>>> https://perfwiki.github.io/main/
>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
>>>>> to https://perfwiki.github.io/main/
>>>
>>> To speed things along, and since the old perf wiki was near-unusable anyway,
>>> I went ahead and set the redirects from perf.wiki.kernel.org to
>>> perfwiki.github.io.
>>>
>>> Please feel free to follow up if we need to revisit this, but things look good
>>> to me with this change.
>>
>> Thanks for your work, it looks good to me too.

I have been continuously improving the content of the documentation, so please
feel free to share any good ideas you may have. :)

> Thanks Konstantin and Yunseong, I think it looks good!
> I think the pages need some improving, there are empty pages and
> things that look abandoned, such as the white paper linked from the
> side bar:
> https://perfwiki.github.io/main/white-paper/
> I pushed a few improvements to the glossary and useful links. It
> should be as easy as creating a pull request for others to contribute,
> so I look forward to this.

Thank you so much Ian, I added per-page editing features to make it more convenient
for people to edit the documentation and submit pull requests.
Link: https://github.com/perfwiki/main/commit/4289b6a6e5c2e53d69a7605d01d0773366a33c52

> Thanks,
> Ian

Best regards,
Yunseong Kim
