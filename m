Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64176270542;
	Tue, 20 May 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757372; cv=none; b=tizSWuJ7cPDv1UcOSE2mOxCxqsAGpG7MoXKq/qT/p5soXpMKa/ekGxap6Lw5ACP7i0O8DeeLPZd2klRETCqb0C+n4MUgZu0eF3asCGz949BxdNiyEDGqiE4Eu4r4a6zvYtWDDdTzw4bLIycU+5V6MyuQOmmFJ2zxpr++7cf/tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757372; c=relaxed/simple;
	bh=4y/qKE3oXhTqvXhd4ZISNZT0anW5reINQI6S/nbqWSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwRWRDG/e3UcbU6VSG9nqA9S9oQuuFoplMELxACsc1rGthp8yw4LPdKamz1m+KGPyOWbftVsi2ynxczdwm4+pZEeR68UVCAmymg2FH0cWelCkmuTRzrppH1BYa7WcCg/Hl/s6yfTFzcbdp0MPEmRJgO5fkDW/qUuuT0en5uwyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNsn+Akw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNsn+Akw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23035b3edf1so48349795ad.3;
        Tue, 20 May 2025 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757370; x=1748362170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXUq7I2DJ01u5ig31a+t8nLTdhkBOXCcNFjoQKTY/Xk=;
        b=MNsn+AkwNBCdfX69M2OESqQ7HibHgWSO43Lsxv+Ec2jT0STY6oKxQSB+Beiq5g+wnL
         5UBhezFgnU+Z1BPtDyUG2GxWwS+YzENgmRxy9WmRYze199aYJQWbA5F1n382lTvzVqqY
         s/by6zj1oQNzzYv/afNrJfIUKRQqD+bxOACQSyfmfNznsiOrneYcS+fpbYCIIRwTlbVT
         aB5AfVfSX6jr7+yNTLH2BbAiTtPzUJbd4lIWeG0MASgFKwztK+hEFRwqPvURsHfe9+y7
         1JCcS9QbNlvshzzmbsT8UL2s5WW8R1e7mwS4eHX6pIRFf58UERxL4GwVf8B6w1W6Iqgi
         ucSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757370; x=1748362170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXUq7I2DJ01u5ig31a+t8nLTdhkBOXCcNFjoQKTY/Xk=;
        b=fkF0SPjgccntMmkKiKs2lSqxlVFN9ov6MY6UR6ibk6c9odehQj21GB5/0yslIWsP6i
         tzh8zwlDruy/aQ4ZAkqrO20x5w/HhNCTBTF+5UrSEKOu/oE0kXLm2GAc0Xjx/Mm1NTl2
         FRL3U/+JVi5GaCiqqakZvAi3QYET0WQ4v5dSAUxEXOFZxHaVto2LsFgEi5Q0IJYXrEvL
         BJGMIpC7aTJRezHqys0sElRlDZMlQSEEFcgo5ipUBG3ZdLdDElEuBfCfXu2rhWFTVRTN
         m/7Pg3GccKW1+NyHjpbsLoq1tcygkrd7olTZw4BGbkyn3WMHACUW9HkJ37zSiILuZ3iu
         c0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtg8wPEauPAH2H0rTM6R9WLkd5EFMzzq6OX6XC6YSVG3Qi2RtywZ32JoqW43p7fkxLXc6oEguOvYZFrb69F4a+eA==@vger.kernel.org, AJvYcCXbhjWhZFuBH5EKxeMp1u7bOgaN21gAEFwyNST2dIiw2SBFVdTDDWz9tc3d8rglGqWLuafxZXZbITKX50M=@vger.kernel.org
X-Gm-Message-State: AOJu0YypwqTJWFVI2+AQp/nHh3gEDKi+VPjhz1tcE6AcHg4UNS2XDJRE
	hA9mQSAyelidWdYT83j8BuYOce6I23sDlHrzlIX8zJkxc0Wd1NQcd8mh
X-Gm-Gg: ASbGncuY04s4u73CiMSwUgE9MhwuPG4e2zfooPCH7e0YU7KLBlnZzq3EY7GiVyxK1VR
	yA9Hxud8pdhsMER1P47bQSVPMAfq/EzXQbWK+zxc9m0019Q6OBb7W4aojEIOBdzqdup1yFJrF9M
	LfdLXZ9Dtr+zaEnTyEPEymprJq4n9JOj9gSGwohOEloD1uIbQiqRr9E+QfNYP7jPdH95XTfqCB5
	ZdMjS/XpWyuq0tKHh3iYpw/KOeEHjrpvjwugP8MKhEyrpD8Y9T3u0ap+fKWB6KkbVYD4HbEtml8
	YVuDxfWrLKfOaYJDd2wQmO0NHgBAUkxY27clb0HQqeqPfNeDt1H/GX/FOhiB8g==
X-Google-Smtp-Source: AGHT+IGlY+4qGiVYGkePf0lzN9iU6nDyoQQ7FwNNs8X/omnBobxxPl6KTPcGz9O0qQQ/4n7opIjwIg==
X-Received: by 2002:a17:903:41d0:b0:231:c86b:ff77 with SMTP id d9443c01a7336-231d43cd9b2mr234497715ad.26.1747757370498;
        Tue, 20 May 2025 09:09:30 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e975f3sm78278245ad.117.2025.05.20.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:09:30 -0700 (PDT)
Date: Tue, 20 May 2025 12:09:27 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH FYI 0/7] Updating some kernel headers with the kernel
 sources
Message-ID: <aCypN94qz43zLgbp@yury>
References: <20250519214126.1652491-1-acme@kernel.org>
 <aCv7e4Jr0s6ViN1I@yury>
 <aCymNKCDygqWrd20@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCymNKCDygqWrd20@x1>

On Tue, May 20, 2025 at 12:56:36PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 19, 2025 at 11:48:11PM -0400, Yury Norov wrote:
> > On Mon, May 19, 2025 at 06:41:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Just FYI,
> 
> > > 	Updating some kernel headers with the kernel sources.
> 
> > For patches 5, 6 and 7:
> > Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> 
> Thanks, added to the patches.
>  
> > Would you like me to take those in bitmap-for-next?
> 
> Since this affects just the tooling, and removes a warning when building
> them, I think its better for those to be carried in the perf-tools-next
> tree, ok?

Sure. Thanks for handling this.
