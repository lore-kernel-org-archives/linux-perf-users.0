Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102F1E51D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707465; cv=none; b=NLmOEaOhCpSeEhvR66sWL/eR2IOmjmq+o9ajELdPNYwW+KZg56ngbxw7/7Go0X0zFdVbOBtkxslA0np640useivXn+zd617oPrW6Ji6p+XypQ/cHUP5dDQoAaqSBaZvClxX3EhGemw8nPlu+jC6NBkndvbYorkQSf0bYc+6lXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707465; c=relaxed/simple;
	bh=f96nDEa8NHKjLs9xqcw/O4JT0vPq796DN+etc8n5Tvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlvA3YSo0rUqYl+boAs71eyE0UvHca/LSZvrt7kAWxuTSQmH+/AnoulPpT5TEvZ+n9D3ahUsPFSSpxkymZ6/xs6bAJnJgD6ntLVKHZXmtcVb/vSVVzxATiVHLEcluXroJos0oRhN5sYxSZKJcQGWJz5JQocXx5g441MUR3FIZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2P8Djr7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2P8Djr7"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3d8105646so9315a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729707463; x=1730312263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52O7UlAiRB1q3e/wJz1OAEsAKmREJXvHVlWC3TmguMg=;
        b=D2P8Djr7HfEPJaXhG/MdrZzcf7sMxb765b4pn2iCT5aoGNOr9CU3FxcGPRY5Z5jdxU
         trij41td8/yIjtlNwzp3LoPPpblFMtbmqChxOFHe9Hrwfk63P/FgS3qVbzsuKCy0WiMN
         spNFWfoDC5O9oFcvx3e/VrN5/ygHlP7SWfK8+CDWIto58wjVtcSLeUhLrOoPn5wi2uKj
         fmj1aIloEmvJVB+v4qen2fJbOjdwO6p0VAhxc5bLi+sDTaJRlfrMyq4RlSwlrxFAaeUM
         22kXz6+v7PZkaS43jv/R9qVXhN9BFHksyM4v6oywPzFlC+PGLaoKI2K/gP5XZJNdI8OB
         agLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729707463; x=1730312263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52O7UlAiRB1q3e/wJz1OAEsAKmREJXvHVlWC3TmguMg=;
        b=SfVJTL75XAsRqX7co4GttjHBl0/WgKpDbgMAVjZb0+8OOOO6c1pHebzL7of2lX/xNM
         NdjasfEgoXXPkuWu3y0IlljRFe9cmkBzeKevPqcb3bsN+u1KwYmNPJFEiJI7urQ/5iQY
         O80ymlvt4yyBA5pnhfLqwog3PWSr5fzA99eYfpDDscs2ldunHGo8BzMsslLr390P12Ty
         j02hbK4qQQmuOC2C8xFCYo8DmCRwXfk+EPsXucu3d0WXo1lulMxUfjJUiGGnTyi1UJSJ
         PfmvKuCjSpHg/A9WcLyYFmJeAjNeYitiulj5lezWTItnSpHVVUZUUpo7ZcOkmHpTkUPl
         JD9g==
X-Gm-Message-State: AOJu0YwpI8b5kj7VjxlmYkQw6R5rzUIGmM8cTLyEVSvwJo4Lb0mZrsN9
	jDyJ3ymwkJ9otgsilMs0PlIw/kWunQNbixNm7rpdrLJKBfsKrsLK
X-Google-Smtp-Source: AGHT+IGymFCEQV/ipvm68HGJpQfErRlnUTlllFIR3O5LpvMxL5TlZ3HbCaU6pJAqQIefZ3N4fnLv0w==
X-Received: by 2002:a17:902:da84:b0:20c:60d6:2dd5 with SMTP id d9443c01a7336-20fa9e9f922mr21064915ad.12.1729707462683;
        Wed, 23 Oct 2024 11:17:42 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eda2c8ccfdsm1466401a12.45.2024.10.23.11.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 11:17:42 -0700 (PDT)
Message-ID: <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
Date: Thu, 24 Oct 2024 03:17:38 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
 arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
 <20241011-uncovered-original-vole-cda87d@meerkat>
 <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
 <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Adrian,

On 10/24/24 2:34 오전, Adrian Hunter wrote:
> On 20/10/24 07:49, Yunseong Kim wrote:
>> I would like to express my sincere gratitude to everyone for their help in the
>> official renewal of the perf wiki.
>>
>> Additionally, the reason I chose to use Markdown is that I wanted to actively
>> utilize its media features. For example, I wanted to embed videos,
>> presentation slide or display Mermaid diagrams directly on the page.
>> I thought these features would be welcomed by users who are new to perf tools.
>>
>> On 10/19/24 8:47 오전, Ian Rogers wrote:
>>> On Tue, Oct 15, 2024 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>> On Tue, Oct 15, 2024 at 02:25:02PM -0400, Konstantin Ryabitsev wrote:
>>>>> On Fri, Oct 11, 2024 at 06:39:09PM -0400, Konstantin Ryabitsev wrote:
>>>>>>> Yunseong created:
>>>>>>> https://perfwiki.github.io/main/
>>>>>>> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
>>>>>>> to https://perfwiki.github.io/main/
>>>>>
>>>>> To speed things along, and since the old perf wiki was near-unusable anyway,
>>>>> I went ahead and set the redirects from perf.wiki.kernel.org to
>>>>> perfwiki.github.io.
> 
> Links to old pages end up at the main page.  For example:
> 
> https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
> https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
> 
> Any way to get them to redirect to the correct page?

We can use web.archive.org as of September 30th of last month.

Intel PT Link:
https://web.archive.org/web/20240930185823/https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace

Top-Down_Analysis Link:
https://web.archive.org/web/20240930164757/https://perf.wiki.kernel.org/index.php/Top-Down_Analysis


>>>>> Please feel free to follow up if we need to revisit this, but things look good
>>>>> to me with this change.
> 
> Do we still have the old pages?  I would like to check that the Intel PT
> page is not missing anything or munged.
> 
>>>>
>>>> Thanks for your work, it looks good to me too.
>>
>> I have been continuously improving the content of the documentation, so please
>> feel free to share any good ideas you may have. :)
>>
>>> Thanks Konstantin and Yunseong, I think it looks good!
>>> I think the pages need some improving, there are empty pages and
>>> things that look abandoned, such as the white paper linked from the
>>> side bar:
>>> https://perfwiki.github.io/main/white-paper/
>>> I pushed a few improvements to the glossary and useful links. It
>>> should be as easy as creating a pull request for others to contribute,
>>> so I look forward to this.
>>
>> Thank you so much Ian, I added per-page editing features to make it more convenient
>> for people to edit the documentation and submit pull requests.
>> Link: https://github.com/perfwiki/main/commit/4289b6a6e5c2e53d69a7605d01d0773366a33c52
> 
> I do not understand.  Is it a wiki anymore?  If so, what is
> needed to edit a page?

If you need to update the page directly, I can grant you permission to
do so. This is similar to the previous login system based on Media Wiki.

The issue with the old wiki was that logging in was broken(sadly) for
several months.

> Also how can page updates be submitted programmatically?

You can submit a Pull Request or if you have the necessary permissions,
you can directly update the document to add changes to the main branch.

> I had a script auto-updating the latest man pages, using
> MediaWiki API, which I will have to redo :-(

Could you let me know what script auto-updating you were performing with
the URL of the API or the specific functionality? If there is anything
else you need, please feel free to let me know. I will do my best to
assist you.

Best regards,
Yunseong Kim
