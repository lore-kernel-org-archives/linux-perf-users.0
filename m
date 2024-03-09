Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3EFBA4D
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Mar 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009778; cv=none; b=pwd7GDoeOTajymFc9c0KlZejF1qSgwFg/x8r9PoYn70vvi0pld2AqUuA7y3b5fBNabJGS0hDiMbcvBGPqPxlRyGdnNWicKYOtVX2tyy8O/czFsEvA/zGX4Dqf9aNuNb6Yusjin8+4nLuB6zuTFYHZ0mf45cRgRMKk9OcvxbQ00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009778; c=relaxed/simple;
	bh=KxmG+wyO+T6Zq/Qd6IbgqH9vgBtS2JnkHOOhVKkt0yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2VWduuJi8znEtLYCollHa/wDtPOghHfcjjai28e4+5ApJXzOaZ87pULilpFAhRgUEp9QqwhaurOXMG9nnmDxUXXEuESPt0C9qYLo345nv3PKRU4ToROGTjjadR8uSW0PoCVfDpRHD1rpfnnabLVlpEYf2dEOfsnIZmQUIhjbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 429HhSE3003665;
	Sat, 9 Mar 2024 11:43:28 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 429HhRAn003661;
	Sat, 9 Mar 2024 11:43:27 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Sat, 9 Mar 2024 11:43:26 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] tools/erf/util/annotate: Set register_char and memory_ref_char for powerpc
Message-ID: <20240309174326.GU19790@gate.crashing.org>
References: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com> <20240309072513.9418-3-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309072513.9418-3-atrajeev@linux.vnet.ibm.com>
User-Agent: Mutt/1.4.2.3i

All instructions with a primary opcode from 32 to 63 are memory insns,
and no others.  It's trivial to see whether it is a load or store, too
(just bit 3 of the insn).  Trying to parse disassembled code is much
harder, and you easily make some mistakes here.

On Sat, Mar 09, 2024 at 12:55:12PM +0530, Athira Rajeev wrote:
> To identify if the instruction has any memory reference,
> "memory_ref_char" field needs to be set for specific architecture.
> Example memory instruction:
> lwz     r10,0(r9)
> 
> Here "(" is the memory_ref_char. Set this as part of arch->objdump

What about "lwzx r10,0,r19", semantically exactly the same instruction?
There is no paren in there.  Not all instructions using parens are
memory insns, either, not in assembler code at least.

> To get register number and access offset from the given instruction,
> arch->objdump.register_char is used. In case of powerpc, the register
> char is "r" (since reg names are r0 to r31). Hence set register_char
> as "r".

cr0..cr7
r0..r31
f0..f31
v0..v31
vs0..vs63
and many other spellings.  Plain "0..63" is also fine.

The "0" in my lwzx example is a register field as well (and it stands
for "no register", not for "r0").  Called "(RA|0)" usually (incidentally,
see the parens there as well, oh joy).

Don't you have the binary code here as well, not just a disassembled
representation of it?  It is way easier to just use that, and you'll get
much better results that way :-)


Segher
