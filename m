Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632291;
	b=xeQPsKUUFOqedtrizJw/KyAfcpM+SHQMa9Abb4RRQ7H4sGXs0nwYm5oN50LlrFZoXR/1
	 V9yyw0OpWzx+U6ENs1xA2dxoNcVa9ry7w7VU/O2j32QK7UUNfGcMt2sYR2psJhVqLN7TZ
	 2xb9Z9SYXcBT00Q7dMpZosMjVCKSiNnTmIemw5FoosER+us6/JwCFwgUnzBR+ZPcP6KJ1
	 Xpb6hFjgywDKOZEM38aGX+tzR5TyzKH4eARvzWMSfLxeX6SxucLEFeIymBi/5JLABGqcl
	 z1Zwyp1i585teo4Ba0iOuXBCu3rP4pOccWMvzdeXlV5Ttkty1TcZlHuY+81OWtUdHVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632291;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BKhPGN180RFu2/grQW2UNifbxv0N3gAL244P7zoLa5U=;
	b=cI8+1iFgo1oweL61kGVbf+/+xYcvkb1LX0+9Cmg3oxhJ8k9xXmLizDbGhUEJWMFBVODi
	 3OJTFLThG2E7UfgHuZ81MQ6WRgMqSWl+/azAdM7Px0NEapdzKUJ5YgtjS/j4pGBMYOWf9
	 NxICAWZ3zWpb3RCVD5oH4lBqqfgFBf09waGZNAKcoiOLRd4HvPUCDsqS2iQ8iKBqnFvR1
	 M89PYsu4qfH/3ls9kqB0of+vlxyHPVEcvhTDe+GItuhRvQUC6mUPZArr5zWfFk/UYpsph
	 rgHdFEHGdH5kXjdwbkTVW1JN5RZ2Ibe/qVYlphJ/e+qWtRqLHBfY7iuW7GiqyAdou0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqYUcRPh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E11606A334;
	Wed, 25 Nov 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqYUcRPh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9371F000E1;
	Wed, 25 Nov 2026 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632291;
	bh=BKhPGN180RFu2/grQW2UNifbxv0N3gAL244P7zoLa5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YqYUcRPhWCNTKfN4EJu8R56acer6B6KI+ptFHNE0xPPVN1yLnnV8DQu7tSNR1rIAn
	 IAHxcFH3UjYBRKS7/0jV6aBIJm5OnCZoljAfNR5TDvvJ6b/bv2YZyna/m1gEQgwyJb
	 pM4vVNW5jKdxcJuB4/HM6I36Ws6RC60eQ0eoB2fnJAIatxsSRiKnON0OtZuXVkCwJP
	 M8vRF120gDWrLt6BV2sDs/77+DZ5DNdjPvffJRk1ksRK2T9i58gWbVn2+OK7lF6aFe
	 ZnyPlXtMT4BluLV/foFfPzVLEY8QTONG/UZY+8X/gSFZtbUcMztNe2ZgJVyB/BFNlG
	 7B7fgrWaWylqQ==
Date: Wed, 25 Nov 2026 15:44:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v12 02/19] perf annotate: Handle absolute addressing in
 data type profiling
Message-ID: <awcsoGb_RJsvg-OM@phoenix2>
References: <20261123220024.14891-1-acme@kernel.org>
 <20261123220024.14891-3-acme@kernel.org>
 <awYM6TM47djixK5N@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awYM6TM47djixK5N@google.com>

On Tue, Nov 24, 2026 at 02:17:13PM -0800, Namhyung Kim wrote:
> On Mon, Nov 23, 2026 at 07:00:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > x86 code accesses globals with absolute addresses, and 64-bit code also
> > uses the same encoding for MMIO: the 64-bit kernel's
> > __default_send_IPI_dest_field uses a disp32 the CPU sign extends, an
> > absolute SIB with no base and no index.  From an allmodconfig clang build,
> > arch/x86/kernel/ipi.o:
> > 
> >   890:  8b 04 25 00 c3 5f ff    mov    0xffffffffff5fc300,%eax
> >   8b1:  89 3c 25 10 c3 5f ff    mov    %edi,0xffffffffff5fc310
> 
> Oh, is it reading and writing to the address 0xffffffffff5fc300?  That's
> unfortunate and probably it needs to parse the encoding then.  IIUC we
> cannot distinguish it from "mov 0x1, %eax" and treat it as memory access.

Yeah, we better stop using output from tools to parse and derive our
logic, but while we still rely on parsing output from llvm/clang and
gcc/gnu output:

commit a49c0a8cc5d9402d01531938955f5f606f7ee765
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Sat Nov 14 14:05:53 2026 -0300

    perf annotate: Handle absolute addressing in data type profiling

    x86 code accesses globals with absolute addresses, and 64-bit code also
    uses the same encoding for MMIO: the 64-bit kernel's
    __default_send_IPI_dest_field uses a disp32 the CPU sign extends, an
    absolute SIB with no base and no index.  From an allmodconfig clang build,
    arch/x86/kernel/ipi.o:

      890:  8b 04 25 00 c3 5f ff    mov    0xffffffffff5fc300,%eax
      8b1:  89 3c 25 10 c3 5f ff    mov    %edi,0xffffffffff5fc310

    These accesses are local APIC MMIO, but demonstrate the absolute SIB
    encoding.  Absolute global accesses in 32-bit code can be resolved to
    types as well.

    llvm-objdump prints the same displacements as -0xa03d00 and -0xa03cf0.
    The operand parser only recognized offset(reg), so the resolver skipped
    the access as not a memory reference.

    Parse a bare hex number as an absolute memory operand, including the
    negative disp32 llvm-objdump prints, and use the address in the resolver.
    The displacement is sign extended for 64-bit objects and zero extended
    for 32-bit ones; values that do not fit, zero and relocatable addends are
    skipped.  A bare number is an address only in AT&T output, where an
    immediate carries $; Intel syntax prints both bare, so there it is not
    taken for an address.  Branch targets do not come through the operand
    strings at all: call and jump operands are resolved by their own parse
    methods.

    An absolute global load records the type in the destination register, so
    the state is TSR_KIND_TYPE; a POINTER state records the address itself.
    Guard the comparisons that made a -1 frame base equal the -1 "no
    register" of an absolute operand.  A no-register operand is not looked up
    as a variable, but the %gs:40 kernel stack canary is still recognized;
    other segment-relative operands are skipped.

    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

The code addressing that will be in the v13 post, which should be out
soon.

- Arnaldo
