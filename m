Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36D13CFA8
	for <linux-perf-users@vger.kernel.org>; Sun, 27 Oct 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730048932; cv=none; b=ZhzoRhXa05lnvVk5LFXb+M1MaJiHHITEj1yUJRRX3IORCdvkgvRgn2lylc4lEpqRgTCxj+7yXFfs5T7ALYEP5oFzx3Q54a+890eDADtxl0hmSzHMo1H3glrbIaF3Iwx2IVBXfQ2cmlLcYwSadB/Qvo/VHX85cBITiU739HInbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730048932; c=relaxed/simple;
	bh=/rSq4HBevlGoVtEzMPx1P/T49/CXYS/HHsKMX0UP5tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbyPD5gu7nM0dsHCVvel55GA0686exqi4lwYVbBuZPv6nP70P0j4BDBilfcnGpHmxAP0NHihURXDukwUtFffXkzggyYhrMcsf1RiTff9dtd1XxMGREPNgraPkJ7Nf2TRqG0JuGPZeA3SpBrq3NdRxsRL+hvgp3HHzqGvzK3b9to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGx5fXKX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGx5fXKX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e31aacbbso596281a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Oct 2024 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730048929; x=1730653729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkcvVfsysqI2eFAR+j5uzBcxc0CguTkHSVnXGnPzkvk=;
        b=hGx5fXKXpa8we7O9xgAfeLWPOFp+FyqznMpzP2bpxgtgrRBDNfK7++5dJOiQ9/2+HU
         eGtWywNp5MLv8OSIgkCRHRSiJLtSXwsNJSuLPPbJbaJsYu7AqMsEs67HnGzdH9tFMsRI
         ZO4M9re3SJ5oM7d3/228xv2d/Z8p4vhOgomgsNXSDYCTknK9rEAQcPW+Dfcz1/UnaZ+E
         HatCOL0jJLS45obHg6U1N0zslf8AS5au9vmdMJ3r40H1mElq2sLkFlLUS7PDWKWM+S1a
         e/IAp7JomR7+OtcBtL+Yk+Lw43UcI3+a3xRy+H19Zr0o5nKNfzAL4Dv47rgPu9Bjfva/
         8zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730048929; x=1730653729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkcvVfsysqI2eFAR+j5uzBcxc0CguTkHSVnXGnPzkvk=;
        b=EOGupsvRs79A0J8uCzUunLtivPf0Rrwrd3ZM3yIVzKkxzCdpdG2yXZ473LuNMjCTri
         9LEvzrX9i9UFDrkeHvBwBF8i0jOTBfswUzIZHU3A2IhY8i5xJRi3WwgO+S07yJoBRI58
         aAdy91EL/zulzcvyQHEluY7Yuj9meJ07hbDwrnCYfzIzcQsEcP+I4gnwTo2Wsaa/K6zB
         uKjEAe0WX+uWPaAws7kcdPMS9jRXW2mSxDm/Rptxc1HVOcLbtXU8wx53Br1DG0uS6QWq
         NrahxWlGHUSDY9y0T1HaSMaBcar3dzfHtd5QItcpGZyYWKOvFX8lzO8RSYHBB0v6mbeN
         /ThA==
X-Gm-Message-State: AOJu0YxIMMhULTSQumYo3znO8mzpXhIkx/dFzFnrrtYdVpedxI/7gUe1
	ZSmAZU5I56Z2tQO8rb22xOPpCVqZpDM4XgM7nphE4EFB4KnskuYx81Lusg==
X-Google-Smtp-Source: AGHT+IGV1BsaUIOod3bnmnnmhZHoEx6YHAJ/haWY8wAlqGYcD8Q0cWcDrxmRPB4SV6HwvqmzKJurPw==
X-Received: by 2002:a05:6a20:9143:b0:1d8:f2a2:23ee with SMTP id adf61e73a8af0-1d9a83d5a86mr4092812637.4.1730048929429;
        Sun, 27 Oct 2024 10:08:49 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f28absm4281374a12.68.2024.10.27.10.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 10:08:48 -0700 (PDT)
Message-ID: <3a6a3cab-6d4f-4136-97d9-3042279eb7a8@gmail.com>
Date: Mon, 28 Oct 2024 02:08:45 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
 <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
 <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
 <ZxlwoN57PF_5YX0F@google.com> <Zxl5sduEDnoxEmd2@x1>
 <533a9e5e-b320-41d6-8d8a-223f69d719f5@intel.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <533a9e5e-b320-41d6-8d8a-223f69d719f5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Adrian,

On 10/24/24 2:58 오후, Adrian Hunter wrote:
> I would prefer the source.  Does anyone have that?

Looking through the archives, I found a source version that predates
September 30th.
Link:
https://web.archive.org/web/20240526075334/https://perf.wiki.kernel.org/index.php?title=Perf_tools_support_for_Intel%C2%AE_Processor_Trace&action=edit

The Markdown version is available here:
https://github.com/perfwiki/main/blob/main/docs/perf-tools-support-for-intel-processor-trace.md

You can edit it directly:
https://github.com/perfwiki/main/edit/main/docs/perf-tools-support-for-intel-processor-trace.md

Once finalized, it will be visible here:
https://perfwiki.github.io/main/perf-tools-support-for-intel-processor-trace/

>>>> Intel PT Link:
>>>> https://web.archive.org/web/20240930185823/https://
>>>> perf.wiki.kernel.org/index.php/
>>>> Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>>>> Top-Down_Analysis Link:
>>>> https://web.archive.org/web/20240930164757/https://
>>>> perf.wiki.kernel.org/index.php/Top-Down_Analysis
>>
>>> The corresponding pages in the new site are:
>>
>>>  https://perfwiki.github.io/main/perf-tools-support-for-intel-
>>> processor-trace/
>>
>>>  https://perfwiki.github.io/main/top-down-analysis/
>> It is unfortunate that we can't have some sort of mapping from the old
>> URLs to the new ones, I can imagine other sites having links that now
>> will get broken 😕
> Why do we need mappings?  Just use the same page names and have the
> redirect keep the final part of the url.

If possible, I'll try to set up a redirection. Thank you for suggesting
this good idea.

> By the way, the new "wiki" doesn't seem to render "page not found"
> properly for non-existent pages:
>
> 	https://perfwiki.github.io/main/not-a-page

I'll work on fixing this as soon as possible. I see that it's showing a
404 page but the webpage style is broken.

On 10/24/24 3:07 오후, Adrian Hunter wrote:
> On 23/10/24 21:17, Yunseong Kim wrote:
>> Hi Adrian,
>>
>> Intel PT Link:
>>
https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>>
>> Top-Down_Analysis Link:
>>
https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
>>>
>>> Do we still have the old pages?  I would like to check that the Intel PT
>>> page is not missing anything or munged.
>>> I do not understand.  Is it a wiki anymore?  If so, what is
>>> needed to edit a page?
>>
>> If you need to update the page directly, I can grant you permission to
>> do so. This is similar to the previous login system based on Media Wiki.
>
> Yes please.

Are you using the GitHub account from that link?
https://github.com/ahunter6

I've sent an writer access request so you can work directly on the
documentation in the repository.

> I updated the latest manual pages last month.
>
> It is disappointing you did not contact people still updating the
> old wiki.

I apologize Adrian, You're right. I missed the part you worked hard on.
This was due to my inexperience. I will do better moving forward. I'll
double check against the web archive from September 30th to make sure I
haven't missed anything.

It may take some time for me to complete the work, but I'll do my best
to make it as quickly as possible. Thank you Adrian for providing
valuable feedback from the perspective of users who have been using the
wiki page.

Warm regards,
Yunseong Kim
