Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2363A5437
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984958; cv=none; b=JjAAvjAz9DoRD+I2qgrVwdAfT+Wk88oNM2PLOsJF2YsQakBFGXvoPIjF3+23LGtpLro7y5/uUyMzXGolB0x8rkb3F0sT70PpA5N9ZgW2uOlv4/PnMHZROM/aDYSzMP2re42K2LAy0E9h8IQ9uNeUyrnf9RZ8VcPdaPjbGyfBuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984958; c=relaxed/simple;
	bh=QGLSjmC6HzWrqtKE8XsAkxjXH6jSWHbmDSD9hEuC8iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDcw9rT/0wwBjEqmXFLkffnH1U/KL/OlbW7QvNLx64Rs+urEcTk9SyRvHF8e7cnw429E6Z7AzvQ+UY5fiL23x1uoq2xs7T/HdVTNTqv3ealPgAJcmastR2UCcvdL4Oq2Lyb5qzIkimCZ7hHM/xszLJrlqxd6TVtjHu4gl0DYt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+2V1gSX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+2V1gSX"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so7205648e87.2
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774984955; x=1775589755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cu9xc6Z6Z9QmL8sIvHSUZsnvx8u8y0fZ0HnTq8Q0Qmw=;
        b=s+2V1gSXUO9PfRKhEVZjMZvgYDnvraB2unF9f/qmphR3m+4OYqlIgck961JUZiPDga
         ctZoMQ3iAOikFu/DKRNz8UHKCD6v90IEgECkxjFqQJumvNw+WuFudCGKJUX5qcbFaMvo
         t8AhYPG7gFpNlGd3aZcyNmVHblXzG01htwTYgDJeBfWVzg4HgCSQIXVW6mBcVhD1b7f+
         xfUFKZFP9CbIpLUWEV8DQQFbmeVVp0xOp0FwYD8mAaum2eJrwPvX0N4yo7xx2lvMJFBF
         Txzx0q9+qUil1aOirWxFYgdLf710hGUjv0DCpR948zoYPE3DZ3bgYgO3vJXFR4mte5FL
         LXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984955; x=1775589755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu9xc6Z6Z9QmL8sIvHSUZsnvx8u8y0fZ0HnTq8Q0Qmw=;
        b=mdDS3t19RxfKx75MyCrDujVfyHjOF4HZGLxmEtId26ZfilWqjJlD+2bJ/qweNc7CrT
         0Nz+3QgVeWXw6OD1a4XR2COxf5jm8ZK92wgATjt8fVqZukiILo8w3PT2dCtqXycCfqQS
         dnOz6rqgDlY1mobkX98kRU0WPUSndfDixHwUKP6Gi19TP/g22tXhr+1SveQCTpl8n2db
         hf9HOyEw2XFWXYkKV6/4ohplS9zEdn3bT05zYZMyntHwikquA8BbM59tAZudaIv5C1NS
         W904KeCMjiUvSbPp6hmRieA1qYvSYLHEnHa3plecNRzUqZKvHGsM9XHJVRCChRheMjNa
         BWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZFnR+B9bKPo0Tlg+BWXWebYYFznJSPmfeOhn1FbsfRIgW46Jqn3QgnolHJzij4Kq3iMlq3Y6tcSqK15QdHx5w@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1gwL2XyIbY9dAOSKqcvC2HaHnsXGCG64tjsaO40yzKzNW53b
	FCEKhYEHXZOnfxYjkW+G+xbbev5EnMnTkYZR1p2oHYf6XSb0JYu9su6G
X-Gm-Gg: ATEYQzw/6aPAxc2VJ68eiBbAanMmSJMK6UEDPJG7nF6e2N3wnvce72GuKksOTL5pvt3
	dc8sHLtCVEx63KLv97eQLprI0CmnJyEPSyphPX7DiZWMAQbDlBhEf33pT5H20xB6yDg0ZAe/ufl
	Wl+Vh2Y5drhQigeS6D/1ZG+l+P1PMY4hcING4gW01l7tMiSkMzow3PcuEREGTTGY4nNRgb1BOWy
	+MrOFlJr4OlXoORXDzoLpDFktuUtTHU8cnwn6Xi9gW4uSHEm/Hd5+BIYDQyC0/ymAcJp8KCmQa0
	lDoc2FSBOp0aRUufh5++ItPagw9pbiIF0NZJ/Vqgo3I+9S0DwyuPHirDmKxDZ4fjdaPUOK22jIF
	NR9ZMQOo3bxJj+bMTTEgr43UZ3iOIwgae5ts81Z8WaPWKzb/HsQMx160oBbvzGP232yCctGHMUe
	7PwKVzJ6fIBZlOeYTe7SYnBp+THEqzTOIMgfYYeG2Bl0iFReQQdxqeFZGO/PPrT1tRL0U0vybuF
	qUNAiyLAZcCLsUuGSRoTnXMZbA+LhSzU2CBUIGROeOYmnR3
X-Received: by 2002:a05:6512:a88:b0:5a2:7ddd:ec16 with SMTP id 2adb3069b0e04-5a2c1f2c29fmr184994e87.40.1774984955144;
        Tue, 31 Mar 2026 12:22:35 -0700 (PDT)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-084-056-106-044.084.056.pools.vodafone-ip.de. [84.56.106.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b144e99bsm2716350e87.56.2026.03.31.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:22:34 -0700 (PDT)
Date: Tue, 31 Mar 2026 21:22:31 +0200
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, miguel.ojeda.sandonis@gmail.com, 
	a.hindborg@kernel.org, acme@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, dakr@kernel.org, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <wqmqx6rnqrociriliyojihkxi3llractltkfcwznzu2g5gbieb@y7eaaiee5x2o>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
 <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>
 <kr2bfp43sqatdssmhzpmogs2h27ddbmegvaknxb6by24n2t64h@hv4m5myvswpa>
 <acts0fXgsuirBp9G@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acts0fXgsuirBp9G@google.com>

> On Mon, Mar 30, 2026 at 11:42:25PM -0700, Namhyung Kim wrote:
>
> We have this:
> 
>   Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
>   {
>       do {
>           vr_die = __die_get_real_type(vr_die, die_mem);
>       } while (vr_die && dwarf_tag(vr_die) == DW_TAG_typedef);
>  
>       return vr_die;
>   }

Indeed, I didn't finish the analysis, fooled that the diff was solving
the issue. Adding DW_TAG_typedef into __die_get_real_type still fixes
the problem, but due to different reasons:

* check_variable calls __die_get_real_type directly at the beginning and
  stores the result in type_die, which is the result of the function.

* if it doesn't resolve DW_TAG_typedef, the flow goes into the
  die_get_real_type, which stores the result in the local variable
  sized_type. But it never copied into the type_die, and never returned
  as a result of the check_variable.

Hence we either need to add DW_TAG_typedef into __die_get_real_type, or
copy sized_type into type_die. After some testing both seems to be
achieving the goal.
