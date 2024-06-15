Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F41DFED;
	Sat, 15 Jun 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718468470; cv=none; b=PdIHYTWLDOEUEMrFJO0TW8TnJ5mA0L1L567ZsK4d/yXaGXjbcfaiS31i4Sgy5gmj+havklJW9LiWZL539zT2Yj40bzRdjOi4XGigPZ4lL3Nz6iHxsdNQrZl04N+jnZMZfjp8N6jPttBZN0A0tplpdCzxv5DZAg/qovaG1m6baQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718468470; c=relaxed/simple;
	bh=/6ch+qcDo2MnkoBjVji3kQHm7RQTr+qczYnFfSjaNGI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nABw1rw8rLHatipeFN5FcFY8F9bA/8RcidapYuHeRtB1m/B4bB7AYwhyYmKK3OdsrIdMD3upEQWznGaHE8CQAwdcsqD/c/ZULLX8sH62wYEBVfe3UxQfrb12UJ/9t+fGZyFYlCh7f2bgTFLA5BZAZs/Mfe79XrZySULJJG3c/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=JcExtjxI; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="JcExtjxI"
Received: from vra-174-141.tugraz.at (vra-174-141.tugraz.at [129.27.174.141])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4W1h0h32dlz3wV6;
	Sat, 15 Jun 2024 18:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1718467750;
	bh=Igjx9GfiOHGZFSH3MO+mk+/P1QADm/jiDsEmEwOLM6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JcExtjxIcH4p61MtHvpDIteBnwfOz51tS8q5VDIYZI+NpJKKdBykTD9MF+auMH0gv
	 nRpGkZ8wiqt21vJ92fMlv2TD3fQC7DD0VpoTzbPNocoCPNvnvWiCaaMcQRcSwRThCk
	 mT/+fqYdLYEQgJHJizSid5Nle80AsJ519MKqmu88=
Message-ID: <c8234b8e2c9c1122eec73c97901e36586160f0cb.camel@tugraz.at>
Subject: Re: [PATCH v4 0/3] Hardening perf subsystem
From: Martin Uecker <uecker@tugraz.at>
To: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>,  "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,  Matthew Wilcox
 <mawilcox@microsoft.com>, x86@kernel.org, linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev
Date: Sat, 15 Jun 2024 18:09:07 +0200
In-Reply-To: <20240614101708.GO8774@noisy.programming.kicks-ass.net>
References: 
	<AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
	 <202406101010.E1C77AE9D@keescook>
	 <20240610200544.GY8774@noisy.programming.kicks-ass.net>
	 <202406101438.BC43514F@keescook>
	 <20240611075542.GD8774@noisy.programming.kicks-ass.net>
	 <202406121148.688240B@keescook>
	 <20240612220821.GA18881@noisy.programming.kicks-ass.net>
	 <202406121530.D9DB956C8@keescook>
	 <20240614101708.GO8774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: -1.9
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

Am Freitag, dem 14.06.2024 um 12:17 +0200 schrieb Peter Zijlstra:
> On Wed, Jun 12, 2024 at 04:23:31PM -0700, Kees Cook wrote:
> > On Thu, Jun 13, 2024 at 12:08:21AM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 12, 2024 at 12:01:19PM -0700, Kees Cook wrote:
> > > > I'm happy to take patches. And for this bikeshed, this would be bet=
ter
> > > > named under the size_*() helpers which are trying to keep size_t
> > > > calculations from overflowing (by saturating). i.e.:
> > > >=20
> > > > 	size_add_mult(sizeof(*p), sizeof(*p->member), num)
> > >=20
> > > Fine I suppose, but what if we want something not size_t? Are we wait=
ing
> > > for the type system extension?
> >=20
> > Because of C's implicit promotion/truncation, we can't do anything
> > sanely with return values of arbitrary type size; we have to capture th=
e
> > lvalue type somehow so the checking can happen without C doing silent
> > garbage.

What is the specific problem here?

>=20
> So sizeof() returns the native (built-in) size_t, right? If that type
> the nooverflow qualifier on, then:
>=20
> 	sizeof(*p) + num*sizeof(p->foo[0])
>=20
> should all get the nooverflow semantics right? Because size_t is
> effectively 'nooverflow unsigned long' the multiplication should promote
> 'num' to some 'long'.
>=20
> Now, I've re-read the rules and I don't see qualifiers mentioned, so
> can't we state that the overflow/nooverflow qualifiers are to be
> preserved on (implicit) promotion and when nooverflow and overflow are
> combined the 'safe' nooverflow takes precedence?
>=20
> I mean, when we're adding qualifiers we can make up rules about them
> too, right?

It should probably be a type attribute.

>=20
> If 'people' don't want to adorn the built-in size_t, we can always do
> something like:
>=20
> #define sizeof(x) ((nooverflow unsigned long)(sizeof(x)))
>=20
> and 'fix' it ourselves.

This is likely a stupid question, but making it signed=C2=A0
wouldn't work?   Or is a signed size_t too small=C2=A0=C2=A0
or some architectures? Or would this change break too much?


Martin

>=20
> > > But none of that is showing me generated asm for the various cases. A=
s
> > > such, I don't consider myself informed enough.
> >=20
> > Gotcha. For the compile-time stuff it's all just looking at
> > known-at-compile-time sizes. So for something like this, we get a
> > __compiletime_warning() emitted:
> >=20
> > 	const char src[] =3D "Hello there";
> > 	char dst[10];
> >=20
> > 	strscpy(dst, src); /* Compiler yells since src is bigger than dst. */
> >=20
> > For run-time checks it's basically just using the regular WARN()
> > infrastructure with __builtin_dynamic_object_size(). Here's a simplifie=
d
> > userspace example with assert():
> >=20
> > https://godbolt.org/z/zMrKnMxn5
> >=20
> > The kernel's FORTIFY_SOURCE is much more complex in how it does the
> > checking, how it does the reporting (for helping people figure out what=
's
> > gone weird), etc.
>=20
> Thanks, I'll go have a look at that.

