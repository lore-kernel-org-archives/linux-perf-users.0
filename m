Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320874D37D9
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340638; cv=pass; b=gfeYPmFai9coZJ0JRSkhytIKr0Y/aIhgcfQ0dlc4Rri90Lqogc8Z4GJETq3cup75XTl+djdD3pNY2dx1yaxaBxpDsAyQuXe90706W6mAhzLyNLDfM0sl0kvozbOtPpnH+griLhWyhWQCQ69nz7ePrBaC3l5tXcTWKjxAsqbu+As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340638; c=relaxed/simple;
	bh=eXFnMrvjWhAjkzGsPW2qsKgsH1CfzHALxNzDTq3muFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwGMQOp62yW+oqnAsHahKDxY8jjv5QLpusGhDLfsOxOHn912il8Yy6g56KSBTJO+uQG3tWBtXz3v1BXRZPIL9vYx4zfXDq+yAir6Ge0yzLFw8ajMW5cTc/5q04adF/5gdLDBvQX24E/S130sAm4SE5K8B28F1uJu9W1NP2bsZ+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=47RJPdEs; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="47RJPdEs"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-679e86015e2so120253d50.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 09:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792340635; cv=none;
        d=google.com; s=arc-20260327;
        b=i+DSp+aLH0/SIkQZfpQ5dPrve8GsWhqe+AC3kz3niY0btPl68fTwK2NEsWU54NLEVL
         ojC/fbHkKvcbFGckmFtrxP0DUCvYUoOabBG4VYjx5nLa0r3+5FmRlZelSWp6Cmhz1yk8
         lNa1Snx/FT5kFhBHbbMIRN9zRgUWpwgEjYZVkqLgMvO+kub0CoGb4N2T6CTH8jJoEfei
         /HS9DHqqkjYu7yp1AjpBId4hcPM0ck5380O0hP4SDH0k8DNqltXS0npieKxzANsKBKyS
         gNs/r9JjwQBtPFD9OSGfK5p6FwleHj9r03wpeM9xb+j8KddIZfdAZHviE3r6+fd7V8lK
         EWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+xrX/lMN1wewX+Usmtm5W37p8mKfEaBQAA+QF9DbflM=;
        fh=4H9zWC6WbAquAVyXyxqHvwiro6uR0Phu3vj7ZWjn0cE=;
        b=mcpRk18USoJb66209zgPxcwDGora5Gf2HOngLmOM7zRohENCDOgDfdAvJB4VoH845r
         5H26wcHhQbFxnmuAjPfVt961ZlkZ6NmhXV8ByM8QaAsXUUflWtKvnKhwchSuPSrkMcC5
         FDoJgIBz6Rj8OPhxMsmwYjOUjrhKyhVSC/mXiRhOUwVu5jiX3CnkeJdXE2VorHRGi4Ck
         vKeb/PyJhPSbYlz9F073HXcXDgpuGboQownd/0ZTSmuNfhAUT+eFiQiRzaaZspIDhFJe
         SYi6BZXUY8/Om/6p2ueFSorJVtvv8DhlF84n2qViEQaxys9fii21hkEQzOrJhS4cZW/k
         jHOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1792340635; x=1792945435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xrX/lMN1wewX+Usmtm5W37p8mKfEaBQAA+QF9DbflM=;
        b=47RJPdEs8FI1V+UPrcJ93Z3HXwlkX2IVUsKKVOKXAPmfgv3PZ2VkH2v45Xeylybw1N
         FjzUPkRsJTmY4GISW619L+q0dxEUxOpfAJ1+UcXacHpTUx/oq+LgyZTmWSm2PGvypmxL
         5801Po1GVgVDmC3KwrP6NU5bIql8J3SgR1Iv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792340635; x=1792945435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+xrX/lMN1wewX+Usmtm5W37p8mKfEaBQAA+QF9DbflM=;
        b=GPH9utJi1XahfD1GObdx0cpLhATyDJAqHV1QP6qAgvqoOc94babe8NuIjbYyIuBmIO
         eWOjT/XT0smHDlV8vaGlyywHz5k7JawDfDqXYZq/F9o9sLFj0zABuM1sURVp2VEufsc/
         tkgaUsLBRu/CY1Ooo5HdoN4HWdeuyBUd5buIq3I2mMmcpC1Dk4fokdmlMoF/1iJJpXVM
         cewksPYVGssWsjUYLaktX7CcqwOKDDzMtyMFIY1fwbddDgC08lFmTb/R8E7DWoecvNX9
         bVAi58FRKw5hkwnQ2shU3L082sIxrYruKDWR5uhZVVXEFWDaygc0jSAIPh8Qa1vHEuV3
         mn5Q==
X-Forwarded-Encrypted: i=1; AKwUvByGpo3zGefO3crIC4/P0wEFfONAoFYR77ZP9ahaNxT6fXYQBDni8yvbuLS9Wu2IIP9SVR0fGqJG+Lk5cIExqa0/@vger.kernel.org
X-Gm-Message-State: AFq9FYK94iyyCGSoUziCstoIcFLBqSPeeRhoS8Av2SmwB8YE7wdvn03/
	o4rg2rcSiY2RW3mcXoxBBYoxAhtTB7l3Fpd+4MCLHERno2URjG5/j5H5VLJAqkCwqq/RWe2mVnx
	W2vniPfyZ8fYI+Z/GIhivXpVxl5IcwNkzkoSAXrERrA==
X-Gm-Gg: AYBFou0B4lSkVpmmU6Lq9wriLA2Thrj2KFzTW+Blbq1YRWnPOQevM/V5LuWMPMCNv5E
	uFcdUvjapgdB5qMcqY5VS/NLaYtugw1kIpauyTpnT12Nt2cAJpjgVUJ8KTvlwL4FijXImlXyTnP
	8hOEVOZHqdRkdmGV3QsbL3nnWMfNKgjP9s0TBad4HGnP0Hjk29yN9+evRvHWIQN4vEERTKOpN8G
	spKsPy35gjcceUQ/Xn8ur2wcGBlW+26K2oERN9cmijttND/YVCmpKRqOeA8B+FzKcVKQwUZl68e
	8tUepjAhBt6LSoygD/vbsUmQ+km8gxNCum2zgSXzI53uJ6bNVhtf2WAFFE3mISyZcaOPI+G5ilT
	pWUa3A5hNclo=
X-Received: by 2002:a53:bd09:0:b0:675:6330:caa3 with SMTP id
 956f58d0204a3-679ca92e155mr989546d50.42.1792340634592; Sun, 18 Oct 2026
 09:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-4-165dceb2b049@uber.com> <asbElicX1u_GZu_j@google.com>
In-Reply-To: <asbElicX1u_GZu_j@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sun, 18 Oct 2026 09:23:38 -0700
X-Gm-Features: AclHuK8ZMynVps2Y3SLchlBdfZ3aE85BRwQupiiWxXwuxhVbCtV7qofBZTTpNlw
Message-ID: <CA+w=M=SzevvR2XFU6O9bVv7wKoGXkNLaWSL4aOtHsvkkTDG+rA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] perf script: Add --lazy-load-symbols for lazy
 symbol loading
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,

Sorry for the late reply.

On Wed, Oct 7, 2026 at 3:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
> I thought we agreed to just use struct symbol and lazy-load the name
> only.  With Ian's patch to remove the 'priv' part of symbol and
> hopefully RB-tree node as well, the size of symbol would become
> manageable, I guess.

Ack, in the next revision (v6), I will use struct symbol and load only its
name lazily, as you suggested. I will replace the embedded name with a
union of a name pointer and a file offset. A flag will indicate which
union member is valid. An unresolved lazy symbol will store the file
offset. After perf reads and demangles the name, it will replace the
offset with the name pointer and clear the flag. This removes the
separate index and most of the parity code from v5.

I tested this design on a cgroup profile of a large C++ service. The
loader creates approximately one million symbols. The results are:

                                      time    max RSS
  perf-tools-next                     3.3 s   334 MiB
  v5 --lazy-load-symbols              1.4 s   136 MiB
  v6 --lazy-load-symbols              1.5 s   154 MiB

All three produce identical output.

The v6 design works with the current RB-tree and does not depend on
Ian's series. Most of the remaining memory difference from v5 comes
from the RB-tree node and one allocation for each symbol. Ian's array
storage can remove the RB-tree node later.

Thanks,
Alireza
