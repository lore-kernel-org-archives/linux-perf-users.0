Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013A30C635;
	Thu, 30 Oct 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845573; cv=none; b=cQfISzv6T5W4nVznkzwY8WS6eVRxP2puHdrz19VwrYGSrSMx2ObIeUnBOwdgDaiWwDc5PDDkAmpa9EgqP3ecC9xPUJjGL4ySKzeFYk2cEWkhl0amCQ1fHCFgkP9Wjm6rCZDPdrXgotYkmieoHvm97pBvbTo+Hsqsn4a4yVeooaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845573; c=relaxed/simple;
	bh=KIjAWd5bTmTxiZT0LrGzbix+8eJ4XPaP0KPaWk4ZMcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQDa7S7zdG4Vpdj9+TkAVKnelqqqmL/8me313HexWm86OGouG9s/9OnxVkkl2CCKWtq1I/pRA5gT3Wwxe0MGgLI+VSYLG53SNZTT9aGw1iGpKuTsIa59HciclSOKUlbQ2a0+L5rNyFzdHCfBviY4wJpR81o7t6sEXk+SzQkNwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C2ED3160153;
	Thu, 30 Oct 2025 17:32:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 0860F20028;
	Thu, 30 Oct 2025 17:32:40 +0000 (UTC)
Date: Thu, 30 Oct 2025 13:33:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Fangrui Song <maskray@sourceware.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-toolchains@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <20251030133323.3a81c02c@gandalf.local.home>
In-Reply-To: <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
	<20251030102626.GR3245006@noisy.programming.kicks-ass.net>
	<CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 4p48o1owhpks8jbbpor1tt1qxy33puem
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0860F20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18MBl85QywLhxDsOHEJp0r6hNFHraA59G4=
X-HE-Tag: 1761845560-798367
X-HE-Meta: U2FsdGVkX197tdFE8k6yvJDR6OnwjBxcHP0TNAczSUS9WbroVPiRedvtEKfy5GxhI+CeuqwExj3h7WZOpoHAcpjO2bH9QtkYWnYafr3ci3+AJYXCLDvJfJPxn2rUuTOrDcUDOWTuAyW5Bl8A0fL0Ixbpc77F/TOpragKsmrupD9umWapOTMJF23ZD8VsNzWdbavnfkd6R3ZscV5arXc4LL6daHD3SxH8qCELr7+vc4US3dWosWdQjNx/uceKvmCDn01GlH0X60b2Q74VMOUym+dKNa+gXpp50ElyX7bj52wR4QerK+R9RDsejXtBnhSYtrkT0O7O9PRmmqOXpESuQXRNwO6phTk5nzJK2+lXaAb9dRxvJiPFxV8fjaOzRByY

On Thu, 30 Oct 2025 09:48:50 -0700
Fangrui Song <maskray@sourceware.org> wrote:

> If SFrame is exclusively a kernel-space feature, it could be
> implemented entirely within objtool =E2=80=93 similar to how objtool --li=
nk
> --orc generates ORC info for vmlinux.o. This approach would eliminate
> the need for any modifications to assemblers and linkers, while
> allowing SFrame to evolve in any incompatible way.

I'm not sure what you mean here. Yes, it is implemented in the kernel, but
it is reading user space applications to get the sframes from them.

Every running application would need this information for its executable.
The kernel is dependent on user space having this.

The only thing the kernel is doing is reading the sframe tables associated
with the running applications to be able to walk their stacks at runtime to
do profiling. As Peter asked, the kernel cares extensively on that walking
being simple. If something goes wrong, you compromise the entire machine.

-- Steve
