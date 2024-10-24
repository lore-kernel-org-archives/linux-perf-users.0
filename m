Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C014A0A4;
	Thu, 24 Oct 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736565; cv=none; b=Ck4iWPzGFNRBBsDJPHBD40vYtkereb38rmJ4HeFcCXD1iQU4yoHLRaev4bfeLEQ3oaFezzJ0Y8cWeRhUzz71850IGvyh/vsAQ9wXO61v4tZizUe4eVkpOJkwxgZkxFtoqsXqocxWif1BIwLULQYPVR0x7DkqmhdC7o/gFJtlNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736565; c=relaxed/simple;
	bh=/bsFfXhqxFQeYpxnwAKt55tZ3OPExl8MrGGksL0ndrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYx/z/Y9PBpytvrfpOqE2ITJe3YgshoQlsxfmvXqgk8wNCvtRyC/MuvVgnZ9y5xM2OHxnT0GQoka/mhYPej/v7w805Rb+4sWpxn6Py5A9tQ01vDgT2Brz+a5UnagXLTsjhoy+5i/sn5X94Z8eq2L0Tq7A1YBQXLBpsi+jhU0fuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8BBC4CEC6;
	Thu, 24 Oct 2024 02:22:41 +0000 (UTC)
Date: Wed, 23 Oct 2024 22:22:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Indu Bhagat
 <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, x86@kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20241023222238.5fc17ecb@rorschach.local.home>
In-Reply-To: <a5c67047-94d9-482b-892b-ef1662d2fe65@linux.ibm.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<a5c67047-94d9-482b-892b-ef1662d2fe65@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 15:22:35 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> We are looking forward to implement support for unwinding of user space
> using SFrame in kernel/perf on s390. One major concern is that your x86
> implementation currently relies on a fallback to unwinding using frame
> pointer. On s390 unwinding using frame pointer is unsupported, because
> of lack of proper s390x ABI [1] specification and compiler support. In
> theory there would be a s390-specific alternative of unwinding using
> backchain (compiler option -mbackchain), but this has limitations and
> there is currently no distribution where user space is built with
> backchain.
> 
> How much of an issue would it be if s390 could not provide an unwinding
> fallback implementation? Do you see the possibility to get away without?

Yes. Even with x86, there's no guarantee that the applications will
have frame pointers available. Basically it just returns a stack frame
of one (the IP of where user space entered the kernel).

> 
> For s390 support of unwinding using SFrame we would need to make a few
> changes to your generic unwinding framework in the kernel:
> 
> - Support for architectures that do not define CFA == SP at callsite:
>    On s390 the CFA is defined as SP at callsite +160. The stack pointer
>    (SP) therefore unwinds as SP = CFA - 160. For that we would introduce
>    e.g. a sp_val_off field (SP value offset from CFA) in struct
>    user_unwind_frame that would default to 0 on all architectures except
>    s390.
> 
> - Support for architectures where RA is not necessarily saved on stack:
>    On s390 the return address (RA) is not saved (on stack) at function
>    entry. In leaf functions it is not necessarily saved at all.
> 
> - Support for architectures were RA/FP are saved in registers in leaf
>    functions:
>    On s390 the frame pointer (FP) and return address (RA) registers can
>    be saved in other registers when in leaf functions. In the SFrame
>    format we would encode the DWARF register number as offset using the
>    least-significant bit as indication: offset = (regnum << 1) | 1.
>    Therefore we would need to extend your generic unwinding framework to
>    support FP and RA to be restored from registers.
> 
> [1]: s390x ELF ABI supplement,
>       https://github.com/IBM/s390x-abi/releases

Note that Indu (who's on the Cc and is also the author of sframes) gave
a talk at GNU Cauldron about s390 support. I'm assuming that her new
sframe specification will cover all of this. Then we will have to
implement it.

-- Steve

