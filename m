Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBBF299A82
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744515; cv=none; b=TdrafYUkMTG+KqvMimhS1eK2wQNEOMsSKcnR6vs8rQL6uWqqPP+VsGeC9fRK01i5o5GI1dTZAtyg4YTTsNcprPZ9pxoF21at7EN+iBZomv69vxTfGdSKXtGpEC3dqXFR4tAG51ggTspx54sa8slOG3VHOp1Aa5sttCLvz7cWoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744515; c=relaxed/simple;
	bh=3YHe0k+PHvEsag+VHa9+YZ2Q28Kjv6z7VRpUu0X/shE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g/0oQxOr5iL08Iz01UJ/pnQI5TNCR3UvGTDXs0yDDVi1hXrkkPtnr0/ngO109WKqVCcTaaiR771D0MB8QUjwU/pWQUu3zKA3T59ljCBAB5/b/eEEHgnMdzBEp/cyKQVbRkMlSr43ZMgaYnRDE7rz6WCaQoTuteGs2ReE2nztDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=M4bFyDfH; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="M4bFyDfH"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d0a47f6692so117801085a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1749744513; x=1750349313; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx0ZwLJ3SW0Kae1Wt1XXglLI6wwCOsqp87Ybf6szzLc=;
        b=M4bFyDfHOqJwPpeqpWCF/I0k4egrkQcdtKlGytp19E+D7SO3nvnrOzBtVtj9L4dJw+
         Flr0melE01T0xju2qND+PWyiMSRBmC2pvInu/HvdBwX9yzzHt1ngavdQV/EC0p1PvNFm
         /5UH5Ri79WDQg1IM+TftiGuHJQx/5oYwZ+aG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744513; x=1750349313;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx0ZwLJ3SW0Kae1Wt1XXglLI6wwCOsqp87Ybf6szzLc=;
        b=O++mmRzHIYYrcl4eXK8Xo7RPWRmufSlUsmmvJH5Kpx4S8lnpZEvKgP84iaaGzdAOOi
         NJlQQcizzr0Sx0PwHqwwnjocjfJKQRn4WNuq9X/B/eGZbJOXHbYGOQzbG7DHaQKoxRrI
         nw+9H3xr9GO/0GDdYW9D8KjehxQYgQNOLVFVwE6C2obV5SUzdlJ9rTeSBkpfftx8YZz1
         3sqS2ERXAvmeIdCDzV8WL7RfEe7IWDQMjTcVEijiILb10M3+oiJZQtmPUqaJVGRl0gmv
         u2bppRzzLRRdolOIPTwLG6I+LD03OD7Wz6kB0NHBZ0LrQdpRUVXDppJ1e24yKk8M3zk/
         6U6w==
X-Forwarded-Encrypted: i=1; AJvYcCUSTSwaOO7YInGmcpnVEWJPI5j4W4g+Lf9x1yyfQYPNKkJP793/x/TOcrabXAnbqB39RX6afX5LSsddTp+m3KLy@vger.kernel.org
X-Gm-Message-State: AOJu0YypXcv6o5O4mwEORzuvjNj1anaLth8v7pCpQPTaG5J4SEXU6KfU
	b4BPePPjWYHKCn9aptcadZVQsSpdTCZ8HN03d6K5CRAmz+ELvaGMBX+bnCJPm9bXMA==
X-Gm-Gg: ASbGncsNQdA1onQ+1Qdk79egX3oQxI5B78ojtGO7mPjR3ly7dvzMsB92GOtdF6VxQNQ
	DBs9gTfyp0589p5zFp8HT6kJGO3Rw6vTI0g+c29qvtSwZOxM9yc5bFKp/boU5h6H0mJqBRsBfiX
	QQCWwWahu0tMjJjK9o9rwIcFRzthe0gkcEV47l5IiUwJjoJmU2OkAYXoPTGqjm3qE/NmkZbNGZD
	GJkYMPSarjN91/SucuwKBSfn/iW+e2Tl9cLYgyt9W2lzWgt5L3+gp2bHZmlAclQNZIBqd0Ods4N
	CP4HkfuykFwStyBujo3zist759zDL7E4UmhJPQ2QwR9AUVZYjhmeVlc0TR2/rsdXw3eMzTbnk3U
	ENvlxLQ==
X-Google-Smtp-Source: AGHT+IEHqON53lM97qPneT55hkPQsjRWeaUbxv+fl45+n0nHgfZowZNRP5w89fJGFEh4vv6YXv/+Vw==
X-Received: by 2002:a05:620a:c50:b0:7ce:e010:88bb with SMTP id af79cd13be357-7d3a883450amr1156220985a.22.1749744512722;
        Thu, 12 Jun 2025 09:08:32 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eacbc7sm55688585a.62.2025.06.12.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 09:08:32 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 12 Jun 2025 12:08:30 -0400 (EDT)
To: "Liang, Kan" <kan.liang@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] crashing bug in icl_update_topdown_event
In-Reply-To: <36b65ee5-4bce-4b15-91bc-52604bc8a046@linux.intel.com>
Message-ID: <da4d8a9a-66a4-32b4-0283-ef4687357349@maine.edu>
References: <352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu> <080706b6-ed21-540d-dfae-ae27d130d796@maine.edu> <d8c64a21-ed4e-4d37-8d4b-9d3a9857b7fd@linux.intel.com> <704f6604-547b-f7ca-ad45-2afd2dd70456@maine.edu>
 <36b65ee5-4bce-4b15-91bc-52604bc8a046@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Jun 2025, Liang, Kan wrote:

> Thanks for the test. I've posted a fix to LKML.
> https://lore.kernel.org/linux-perf-users/20250612143818.2889040-1-kan.liang@linux.intel.com/
> 
> It's a little bit different from the one tested. Please check and
> provide a 'tested-by' on the new patch if it works.Thanks,Kan

I've tested the new patch and it also runs my testcase without crashing.

Tested-by: Vince Weaver <vincent.weaver@maine.edu>
