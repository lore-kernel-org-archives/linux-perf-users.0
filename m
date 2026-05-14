Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2631716D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777864; cv=none; b=UWXcKeqm4rzZApOlMG/JoeJcrw+qPKZ65jT6U5l+xsRW0VdXo+a/J6nj+Z1XJW28e/YFBEgJe3HJmCeiNLGmbudW9tsX56xSCDOrISkk8mKb+FufeUNGf3XpUf4VuSsFaXJPS8bKesK7tgs5/6g4r46Gx9gkuZPBsBLbStMOzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777864; c=relaxed/simple;
	bh=/+Hmrtccj9isz4WPo27D40tpQQMJzAxxj37O5fY2+jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFdIaYprnzyVDxKZImCsUtbdR1im/kZRcoYZ+GWxCmXgpaEfucnA3Lrc0s+BStwfJDyEAWFsGv0VjBLWxlDgUU4BxcA7gTPhtZ1m5ZaMwUS80m7FwkpxfXMhc+9/uEHNUSF9j/ESfLa6cqWF62EYyf6BOt82X8GeCTH+qUsFOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CQzYVCeA; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CQzYVCeA"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso6837567d50.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777862; x=1779382662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FglUXF8DBaE4CzgW5JW4Tl8nid6YrjmsNFyuEQHvTuI=;
        b=bBMjr/sVM4iNpZXBugoIQX+5XxGw/o3rjrM8O6DvfLoC5c45KM33kLb8OMMpCb7AGc
         CWudCoepUstl07bIzLVvx5sJcYZ4tXdxpLgKQ2euzdt/d0ej5PUxvYCj39/J3+2ZRf8c
         1QYnju/jM4m+8ACKzKn6NDj2LRwtg6Qlh2KF2sqFw1Sw1w94sZlnP+pigBehWJuNpgHo
         iYex54kZJ8P/OcAc4Ivb9rC3r9E5B8si3ijC9WQq3jwn9MooxygMKZ+GUOI8rmWFiKq/
         AO2m5zvdeUBmNCwgo2wJs4WNmeWmtPbGobQ6/uetB6dqOPr2KjSpKhY88bv/V9ECPhVQ
         u81Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ypBDORie2gnHnoHoSlKNBVbcdw43rFfEGzDBVpy1YOTOMgfi0qTEJxszOB42vmhCJQRThzcUpoj79LnXChnav@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5rSQLKMU58s6RHzWHLbjPhhp0JrbN7+H2PgOYPw64UQlxdAK
	E1nB8HYAFzJf0v0vfsGkW5JmEZ+W3ROHTUFL+JPhk+/zN2e47PNaVYz+PoMexAjPgliDFvIMquW
	rOgC5MBwyu9oCqwmszjUUh1o/5HGAXl4CiZOe+9asHAstva6BdWryeTIUIlDnjNhtrovbaLqTLQ
	ZkcWuvRimLECBTIgpWbLRjyFLMDO3S5X8pqmYsX7oyti/oT9106VKcGctJl643y+9tpCJXI78nc
	omh9yCIkjZ6/KfY5eCRNgIi+80fZA==
X-Gm-Gg: Acq92OGfaSbQTkXlG0g1DPCSlqaY54htn3wjAGnqxVVeHh7/GIusrO4BAu706H/yrSD
	kEZiUXt+R5/v+pOMo/Jxcai+CuO4hC/ajUxKcy0qPxFLY2otEs5eUgEyRQ/muVXGJvLXD/VSM8q
	AMh/bNngEZe6dk7UVH9AqAJbYgTWIZGncQ2CF7IW9ds63/2fKHmJ78hD/Poz7HdEL4fNpCVrWz3
	P4NQzGgmx6h3z6cv8znF1RPzo/imq/FqMYbXbEj7+tCNbBBSFIF3Diqb0UXn6Uz8YaGJ8iN0Oee
	/CYAmOsnsJyORt2QPcu56+e9nhgau3f8Y0jPF9MFHK9N6BVpp2mkNov3QAnWRa9n26SIDGJAxGH
	3qg1RBOJK3crbFvbElnVLz6rTe3UZgGZIISYmKmYfu+4t3ferzdtKK0K7IzX060N11ugybmkqk5
	1/qyifA/ddBGCzc08ksQJQvV45hzOHLaWXDJrnULAo1+tOnDu3TksdAEm6kFEndIFrrN+qERel
X-Received: by 2002:a05:690e:1402:b0:65d:6f10:d42a with SMTP id 956f58d0204a3-65e227cfff6mr47127d50.39.1778777861967;
        Thu, 14 May 2026 09:57:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65e0d867f76sm200715d50.2.2026.05.14.09.57.41
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:57:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-13312be8a31so6135163c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778777860; x=1779382660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FglUXF8DBaE4CzgW5JW4Tl8nid6YrjmsNFyuEQHvTuI=;
        b=CQzYVCeAzSx9q93+2ZejvQ+XEKaH34J/vc4p1h4nNzxHaAZQxqtF9SImtyBskR4FcQ
         HHgfiJ4VhjZBeleWqdzwlvH6+tHg3oFWBo+pe2a6XlOUpEhw/34s3NjWHt44Mh2tsP8Z
         dIhz5ndNZvyfN9JJ02jy62Lc/Vd1i1J1Cr8VU=
X-Forwarded-Encrypted: i=1; AFNElJ8/6LMOF8W6YDimJCyTzHvCyDuwZQCI3knlcDLWkgmDmJ+FTEeGvTt7E9ilquRG0tNvnBD0I8J4MRt9uc0G+uus@vger.kernel.org
X-Received: by 2002:a05:7022:f008:b0:133:680f:cdcd with SMTP id a92af1059eb24-1342ee3a3d4mr5257033c88.4.1778777860556;
        Thu, 14 May 2026 09:57:40 -0700 (PDT)
X-Received: by 2002:a05:7022:f008:b0:133:680f:cdcd with SMTP id a92af1059eb24-1342ee3a3d4mr5257012c88.4.1778777859960;
        Thu, 14 May 2026 09:57:39 -0700 (PDT)
Received: from [10.69.74.234] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdce9fasm4634662c88.4.2026.05.14.09.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 09:57:38 -0700 (PDT)
Message-ID: <9a1b7351-bf10-4120-b29b-7f6b340ae92e@broadcom.com>
Date: Thu, 14 May 2026 09:57:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel
 headers
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, mmayer@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
 <agXwulXp_PqixUCg@google.com>
 <CAP-5=fUJvVGEeA7+mk8KjracroD_5xhSi2pp7eQbEv9xGeq19g@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CAP-5=fUJvVGEeA7+mk8KjracroD_5xhSi2pp7eQbEv9xGeq19g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 5/14/2026 9:37 AM, Ian Rogers wrote:
> On Thu, May 14, 2026 at 8:56 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Wed, May 13, 2026 at 12:23:46PM -0700, Florian Fainelli wrote:
>>> Toolchains with older kernel headers that do not include upstream commit
>>> c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface for
>>> setting/getting write life time hints") will now fail to build perf due
>>> to missing definitions for
>>> F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.
>>
>> Can you share the error messages?

The compile errors look like this:

trace/beauty/fcntl.c: In function 'syscall_arg__scnprintf_fcntl_arg':
trace/beauty/fcntl.c:96:13: error: 'F_GET_RW_HINT' undeclared (first use 
in this function); did you mean 'F_GETOWN'?
       cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
              ^~~~~~~~~~~~~
              F_GETOWN
trace/beauty/fcntl.c:96:13: note: each undeclared identifier is reported 
only once for each function it appears in
trace/beauty/fcntl.c:96:37: error: 'F_SET_RW_HINT' undeclared (first use 
in this function); did you mean 'F_SETOWN'?
       cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
                                      ^~~~~~~~~~~~~
                                      F_SETOWN
trace/beauty/fcntl.c:97:13: error: 'F_GET_FILE_RW_HINT' undeclared 
(first use in this function); did you mean 'F_GETOWNER_UIDS'?
       cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
              ^~~~~~~~~~~~~~~~~~
              F_GETOWNER_UIDS
trace/beauty/fcntl.c:97:42: error: 'F_SET_FILE_RW_HINT' undeclared 
(first use in this function)
       cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
                                           ^~~~~~~~~~~~~~~~~~

>>
>> I think this code should use a copy of the header in
>> trace/beauty/include/uapi/linux/fcntl.h which has the definitions.
> 
> I don't think the beauty headers are in the include path.

I suppose if it were however that would provide the missing definition, 
maybe that's a better path forward to front load the inclusion of 
trace/beauty/include/uapi/linux/fcntl.h?
-- 
Florian

