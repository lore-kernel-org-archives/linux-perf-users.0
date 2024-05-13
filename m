Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A222EE5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623008; cv=none; b=IDr9KRYvLVOAuHuWngyWzJ2oT6PLUxxtgg8STQQmZYfFRNX8XX4nngnxhOCpfl4ccQxbxt+aaMD5ImPav0wtO3R2oKoL8ef6k5tTDXxgD4WZdePoLAnOWXZRC/+mTOJHGzdFmayK//KySTxJcPKb3y+P4iWI3ENi62f4HVsvOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623008; c=relaxed/simple;
	bh=esfXbRwG7qnZ3qAY6JPB8814C04V6QeKv2dosLof97U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxU+PXlTk51j2bFd9ESRmJdkrDVOvZnALq/uDy/1+Mx3qMRc2WElySupRLUURaXqjZaal29KT6B2YJKeCVEbK/TO5xc8j6L3xyo0yRhF9xTPbwd5i169m3AyVtCH2TMNPSr36x8lNNhocfFVnEBKu6ehWqJGhVI92CtfIEu8iSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCZ4omha; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCZ4omha"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36c670757aaso352785ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715623007; x=1716227807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+nmjk1LDFBE4TkVCYE04wzt6Q9H4iHrzCOkGg1jBPM=;
        b=aCZ4omha5JLJqTgq1JzgLJOWv6S+UXufMgIS27HbcJ999/l8OjKM+zEYtPoHTbFQKU
         TaWoyR3CrJEmts3cGYTzLnixBjQeehhRteUnmhAXZh9eI543bbp1+o6lXiHw2hG59jOj
         t/3l/K5Goeg4exvkUCO2sb1T/YFIY5LaaEdiZnaGMnzU9uIMSMFYbfAln7SmqzVrQlFx
         5jL4mHl9OHFYgUmcJlSEKfhe6nEhm42Lo78dLuioeZywtDcqphzRQ+HBWdYwgHEc+g/Q
         dwx8l8dxiCzm8d2xZ+OIhhfxVP+1b+NxB4RSHkCcLT72BJEGj+UB3Y40MbAitt008CNA
         1dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623007; x=1716227807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+nmjk1LDFBE4TkVCYE04wzt6Q9H4iHrzCOkGg1jBPM=;
        b=sXJ5CWNZg0uFcxNYBSWfR7Ha6bEqUQHlJvQGexowVeJ6PjHPwJ20PQv3fM6TogiQt2
         Xtg4xTXjacoIQhwdZgQYv2s+ctvB6v7bp36E3ipJLMQLgyPUriWDhFpNccipIDA8M5b6
         qeZ+CIEHeQR59SsJWrud5qtFgVy/Qbs/3JKowpEg7TX+6N10u7V2F6+bdt06WFRkbth+
         KweHLlXvJ/PBpKCRfXUexTi3FS0iEfL8RctjCvot/9VXW9ieLuqtAsLPKsPOlrjH7v5g
         Dvenm5SPu93/prNAYKVNHoTkLpnOWPWcwIE4IwQXifZoKEHWRKLlkvmxLLU8DGpAhD7h
         ZghQ==
X-Forwarded-Encrypted: i=1; AJvYcCU91rQSKuJJXYmZpqE97/qMHSwXq3bv8tnQDqj2XyiQ0WiExT+u1gVVNl8Y030I6ntvzQxjAFxiD8yykG9+y7IIQ7XhA31F2Q4FW7uEbEGXHA==
X-Gm-Message-State: AOJu0YzfOLR+dfjq6+Sc9TOzhcwZp9Ll0HWgjjHgVzJlPSZGvPW7KtjZ
	JdSbGnCFl+O/V5/JBciLq1Vs4WZZMtaaszG3w2W3XHVGq1JD5V5kNtsTYKYXbjxY74ryD7OOyPC
	ZmvFqqXLoM5OPEyq7EdTTgb5eEZi9J3Y+GHbW
X-Google-Smtp-Source: AGHT+IHQqf1Asv5Fry6t+LsqPl/T7ZSHAG6ZEvWvp2yUvjQx3nMQtPqsrIwcnCAZGf+XZ8lCBBfjus9anmnZBNnigZo=
X-Received: by 2002:a05:6e02:1a8f:b0:36c:2c6b:ba8c with SMTP id
 e9e14a558f8ab-36cccab3700mr4390215ab.17.1715623006561; Mon, 13 May 2024
 10:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513074910.1660373-1-yangjihong@bytedance.com>
In-Reply-To: <20240513074910.1660373-1-yangjihong@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:56:35 -0700
Message-ID: <CAP-5=fW0EE+Wix_Z2o2DxTcOzm89hgsujt9e+MZi9GpRn1OuPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf build: Specify libtraceevent dir to rpath for
 asan/msan build on 64-bit
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:49=E2=80=AFAM Yang Jihong <yangjihong@bytedance.=
com> wrote:
>
> This patchset is for asan build issues. For detailed discussion, see:
> https://lore.kernel.org/all/CAP-5=3DfXJAu8OO_Gaw45Hx3uq6N8VQBNFhqcUy3Zm2v=
KT-TDSOQ@mail.gmail.com/
> https://lore.kernel.org/all/CAP-5=3DfXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_=
Wt8AqFSw@mail.gmail.com/
>
> Yang Jihong (2):
>   perf build: Specify libtraceevent dir to rpath for asan/msan build
>   perf build: Add libtraceevent lib64 to -L directory & rpath on 64-bit

Great, thanks!
Tested-by: Ian Rogers <irogers@google.com>

>  tools/perf/Makefile.config | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> --
> 2.25.1
>
