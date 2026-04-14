Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B53ED10B
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182927; cv=none; b=kfGvuSABz3a47nMcLerOk0wOkYhixqUxd+MOs8P3o+snzRLAD7akNyah68ILuqmZG+iBZfC8if3ZpohWzPstLxjdjHXGsJP/CFjixtxYJlGO5xmhfdrBgpKPd9K1siPhiBnyL6V6a1S2eZX/L6AQOPhE0BtrlbSTo+PQEFR5Oeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182927; c=relaxed/simple;
	bh=/3G/W1wqMw930Wo4/eVE463K5niQWuVxpstiG0s3fW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFERJ0HiK273+ygI9OiBrY9ikvLBQk8utczPpK5OFD1tNTo1TVA4cEQCimvdRKPRMjsjpe5zcATjqKAjsc5ZDJepFAjPvmfp8pKPewKY/XoO1j2A52kOrsRzW1UpwFfMU6Zlr+HSjjN+RLIxS2Mm7Ti8agn6miuxIniYaLVFHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEbTDYUs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEbTDYUs"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so799167766b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776182923; x=1776787723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7WCECxx/155qJE2EfdL4KnE/38VJ4zuJHqpOqEVZxI=;
        b=fEbTDYUsSq/jcbi4wuBr8bI41nLjVorgjNj9pzwrG0oQrg2/2yJaLSatCMTFlx+FcC
         Rj2doBBt6m4ujgQr/aRpQFpB/ULVgwUluv0XXWwzCU9zADB2uIeV9P2MVUFZlryPXlii
         5HgliJ5TsiSR/LRX1bGFU4XZCkVDzjXwe5Tf3KaLGlkX558YFUYgM+JNoXGSXkLXgRKq
         YCrC7DBY/k0jKQH4wKr+3maruLh5CyVL6qPnyhHEOy4fLoP5Gbo5PNWgK425vDBAwEhf
         ip/vxQGSVKqbaR+XXlFqrFYUat+OHbB7KJmtmcV6G+1TUoQ+iQ5icx6R9kWVOekQZqbo
         PJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776182923; x=1776787723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7WCECxx/155qJE2EfdL4KnE/38VJ4zuJHqpOqEVZxI=;
        b=WJ/SZd7tfD7MCAKnpnsil9Cci+bBHWYGLxFx75mPN0QY/AED/elw5m+pRZw/LnY7Sw
         Tn8JXsrpcKDisQVWA7qWJex1yWg6OfdM9F/TWOSqpICUHrgo3Gl1lmhAKEYH+3nLt3nr
         2gGwbQGPmH4+5V9tIjBNj+miHwEsOsa/e2aNT1SE4hADKCm87nChE9Cd50dlJoF/myVr
         8J3CcpBQMZw+hZXukvYnRcNZ7WzVkuGh5BPZXh4AvvsCjMBD4KI9hd6kqYisQEm2PFUZ
         Cs9HI8ak/6Ko3X0ypJB5j9lwjVWHZRSLMb2VEKUTWuA7OVwWUoRIofGHTo835ObeCqk3
         ZwZA==
X-Forwarded-Encrypted: i=1; AFNElJ8qf39KlzqSRuIlqOldTIfi2M9fv5Yl1zz0Sam8lVoSiEzoSRxQG18MYUdViZFMusLvg8LYqcRSmeUkUaGLqADb@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvTXXDJxzaXq51pQ9tw+g5wXBflqJ58ehMVFptjD5osJAplNv
	JPDaLT1L979W1lnrGotGn0hhRfEDPAU8Blgc6bUle37BD6OiI4f3FSrh
X-Gm-Gg: AeBDiesW0Ji7KVmBWPWhvPZjtMgGvPO4QWnfHnBw0WLx+hCImoRShYKGTccY/KAnAQH
	1FO1990GLzz9JSF+LaEmDH8B022+W4oKKtcnXI2VVoVcfGrmLPWrSkQF1A5UGBfQSNF51hR054J
	gbZCu/OFKzHA2lIlwLwuJItmr5Y5Pxjv/bmZTNLfpbZxEP5LmkBxFW9LjYXVMJYS03Jg2Ne1/6w
	TrnkmUdPYAEr77l2fNgFenhbdKR1+4a/9vYnlsMJwSnAGQ271qOo+9Y2KPjJgu2rnbOmy8Opw/W
	1q4FYSh0FMaY+Nti/kqNbhSDuwi/mUT0kJ/uO+4gfqwXpCg7AlCBB1eAEwNtG2I4rpRiIS2e8ao
	GB/SxYCD/5Hlsoyz2y/kdo/yoB2YfokVjLwJBdAFEMOTdjDxekRlR/LKAuM7kpskbm02sQsibID
	/SxIu7tZor+myqRUoNCWgD9EXx9tH9c8VQU4ChXAUuzCsj6BHs3o5VbReYR78NumidzRhIgrKL+
	21gkEFrru5nF3YSPz4L/DFBcmFoTPeZWAEGDHle+LCgfs8O
X-Received: by 2002:a17:907:6d27:b0:b9d:bcc8:4dc2 with SMTP id a640c23a62f3a-b9dbcc84e2emr714208666b.42.1776182922374;
        Tue, 14 Apr 2026 09:08:42 -0700 (PDT)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-084-056-106-044.084.056.pools.vodafone-ip.de. [84.56.106.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c7c81sm408722766b.43.2026.04.14.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:08:41 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:08:39 +0200
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	miguel.ojeda.sandonis@gmail.com, a.hindborg@kernel.org, acme@kernel.org, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <sitnyvaxrsyen63qj3sr7ocelgh7wtgckj7uvsdc2pb5wm7pak@rm33rahctupp>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
 <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>
 <kr2bfp43sqatdssmhzpmogs2h27ddbmegvaknxb6by24n2t64h@hv4m5myvswpa>
 <acts0fXgsuirBp9G@google.com>
 <wqmqx6rnqrociriliyojihkxi3llractltkfcwznzu2g5gbieb@y7eaaiee5x2o>
 <DHSYGL2DY5IU.19MOS6TI1QNOC@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHSYGL2DY5IU.19MOS6TI1QNOC@garyguo.net>

> On Tue, Apr 14, 2026 at 03:42:19PM +0100, Gary Guo wrote:
> > Indeed, I didn't finish the analysis, fooled that the diff was solving
> > the issue. Adding DW_TAG_typedef into __die_get_real_type still fixes
> > the problem, but due to different reasons:
> >
> > * check_variable calls __die_get_real_type directly at the beginning and
> >   stores the result in type_die, which is the result of the function.
> >
> > * if it doesn't resolve DW_TAG_typedef, the flow goes into the
> >   die_get_real_type, which stores the result in the local variable
> >   sized_type. But it never copied into the type_die, and never returned
> >   as a result of the check_variable.
> >
> > Hence we either need to add DW_TAG_typedef into __die_get_real_type, or
> > copy sized_type into type_die. After some testing both seems to be
> > achieving the goal.
> 
> Why is the code in `check_variable` resolving typedefs itself instead of using
> `die_get_real_type` instead?

Looks like it was done in 90d78e7b8e5 ("perf annotate-data: Show typedef
names properly") for the purposes of resolving structs without a name
slightly better.
