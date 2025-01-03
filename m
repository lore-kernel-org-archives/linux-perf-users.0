Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE3BE4F;
	Fri,  3 Jan 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923123; cv=none; b=Z+e+9vkFaoEjhJ60capVHk3GnalhlUDduGwl8by9DoPpiOBVqYCvauGVNej4uVC7i4VAgCgR46Vxj+TdbEdR5SV0Ixy+RiPLNZu9EJfvLAhz3PYad/ka7YLlV5tsrT1BhY/RvXZ5AAub7/1Tt+pOdHafB6yDzZtnk09zy2vuKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923123; c=relaxed/simple;
	bh=58khvkNUqxd3P2obZLHz4AGI382Z9+SOg3N/vpAAXRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnI8zHsTaugQaufSvNYkkJH+D7qhd1EPYu5dB1mAuI+w8OH9aZG86Y67YdDRz4n9jQqY1X38HN5itB3Douu592zUxsSxhfMMKKE6Xk25oE5OUQovulijlUUJA4f4YdKJ74bBHm2qPdUSA1K3buvwhKiNy4JkIa0ZOSv41tXWZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8tBQsBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8tBQsBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC42C4CECE;
	Fri,  3 Jan 2025 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735923122;
	bh=58khvkNUqxd3P2obZLHz4AGI382Z9+SOg3N/vpAAXRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8tBQsBkQUvmKhCM4rkYUmD1LZs/ZLSj7FPA+XimaQZxnVte6RolTuR22n2H7C3ls
	 W00WAwD2OdGN4h+XwJQlSlakVNIerPcqMlEe1P1Rmp/YgTke9U0M+GM//j10Ok51Xd
	 7Co8ZQHwQkWKx7C3a66zNP1NxXjeSDJoUdzaH6RKDs9iGmFhfrLqOjGd4aK6vpzO81
	 0L3gXIeVfEfRFtrV+PnuRBjkWQL+85qow8ulTuYI3EnWVQvSr8OTSfip9saalpc9Fw
	 MPkSVtppD8zh25QkUbxKoHKhR1y0FQ8yVH+NWZ6YwPFO9rldvgfFKrNTqIQyMxL8zI
	 1WPF+E6U6gKrg==
Date: Fri, 3 Jan 2025 13:51:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
Message-ID: <Z3gVrzFd_2cacOFD@x1>
References: <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost>
 <Z2MXXFhUzoQmW4xV@x1>
 <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
 <Z2M4ZparbNRvRHpz@ghost>
 <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>
 <Z2NNcy1jCLqb62h2@ghost>
 <CAP-5=fUBcu=Kd7StJvwdM_ArnSdOjmAcgR7NzDd+Ep8LrNMhyw@mail.gmail.com>
 <Z2N8WLTmh0ojIzhF@ghost>
 <Z3dBGM5L41v0RlZf@ghost>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3dBGM5L41v0RlZf@ghost>

On Thu, Jan 02, 2025 at 05:44:56PM -0800, Charlie Jenkins wrote:
> On Wed, Dec 18, 2024 at 05:52:24PM -0800, Charlie Jenkins wrote:
> > On Wed, Dec 18, 2024 at 05:20:15PM -0800, Ian Rogers wrote:
> > Yeah I agree. This test case did end up being interesting though as it
> > unconvered this change in behavior of objdump on riscv, but that's
> > tangential to the purpose of this test case. We need this patch on riscv
> > to stop this test from failing, but it is also reasonable to approach
> > this differently and not use objdump at all.
 
> What's the next step here? Would you prefer to get rid of this test
> entirely? I sent out a v3 that uses uname [1].
 
> Link
> https://lore.kernel.org/lkml/20241219-perf_fix_riscv_obj_reading-v3-1-a7d644dcfa50@rivosinc.com/
> [1]

I'm ok with this latest version and added it to perf-tools-next,
changing the patch subject line to:

  perf tests code-reading: Handle change in objdump output from binutils >= 2.41 on riscv

Ok?

- Arnaldo
