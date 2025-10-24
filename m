Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E754309DDC;
	Fri, 24 Oct 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341470; cv=none; b=NwoWHwSlLr+F2TCuNsYK/MYQv952YOsVCTn8KrRZ7ocIGVcR8jUcc8ElL8qH3+ds5WD+4b9vJarcSY5+THsrEDVmIMPdUptkdEmhXibsDcXr/EncgfRRDB7hEgh35rWxaRZ0dclLSql9rsqistZNC9NV7mp3cZfYG3XNdRRBuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341470; c=relaxed/simple;
	bh=a5nWUpgjX/SlORZFuatSeSBNce6QWI/+338uOL8xONg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjY29lKc2YHC33hMaKJp2nvRi8PiQHeKG0GbJ47kVQorNVd4Q2Z1yY9lKSg8M6pkYFWQmcSoat4uIh7cWZNwyVSLe2Fxb/UW8JFiJMNTuKbzZduuZcoijBWBEE807WQaoh75mejUr80P/Uc4OuCnF3kkpYZkYFltWdLpJpB8AhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyL8oXea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyL8oXea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2417FC4CEFB;
	Fri, 24 Oct 2025 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761341469;
	bh=a5nWUpgjX/SlORZFuatSeSBNce6QWI/+338uOL8xONg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyL8oXeaWrFMDlD9J8tvQ+EpR0SEF9YQaVtb9n7hr8mf6qkeMarkAs63/SjVBsxbU
	 lIEcBEySOLQ9o83+yugk/MKmKn4Xd8qmMN9m6KaB6aGgQ788ff7+1w5nZioSOTWNgi
	 a2x52tiEce1NT5KTnI3PltTCiDs3m6FgoJWutnJaSWdE8ogTJ0sE3aJb2NWzWMNG9D
	 ebtrFBA/pQNapiMmuyFZEwfpxiSeE2esfOqgtSdy9hFPzn7pSpaf+BRHvXEsnFu38o
	 nInC9D/uAEmsBA2FUMjt6fgTVZXRBs7Tm1uoQ+6i3SS1r9Y8+/pVRlBQtwDQ7l+9hK
	 srfU/xPq05sDg==
Date: Fri, 24 Oct 2025 22:31:06 +0100
From: Mark Brown <broonie@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/8] selftests: tracing: Add a basic testcase for
 wprobe
Message-ID: <aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
 <175859026716.374439.14852239332989324292.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjZBpNS/k9vJ6kRK"
Content-Disposition: inline
In-Reply-To: <175859026716.374439.14852239332989324292.stgit@devnote2>
X-Cookie: Don't read everything you believe.


--fjZBpNS/k9vJ6kRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:17:47AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> tests adding and removing operations of the wprobe event.

Since this series has landed in -next we've been seeing hangs on a range
of arm64 platforms running the ftrace tests, it looks like it's all of
them.  Unfortunately the systems lock up with no output as soon as they
start trying to do something with wprobes:

# ok 19 Generic dynamic event - add/remove kprobe events
# ok 20 Generic dynamic event - add/remove synthetic events
# ok 21 Generic dynamic event - add/remove tracepoint probe events
# ok 22 Generic dynamic event - add/remove tracepoint probe events on module
# ok 23 Generic dynamic event - add/remove/test uprobe events

the next test being add_remove_wprobe.tc, which doesn't seem to
complete.  Full log (for what little it's worth):

   https://lava.sirena.org.uk/scheduler/job/2000440#L1860

I turned on -vvv logging and that generated the rather spectacularly
more verbose:

   https://lava.sirena.org.uk/scheduler/job/2000676/log_file/plain

(in a somewhat processed format unfortunately.).  Looking at that log I
do notice a bunch of "unexpected operators" reported by the shell, these
systems are running dash not bash, though that doesn't seem related.  It
looks like the script hangs in reset_trigger_file while grepping the
trigger files rather than actually trying to do the test.

Sorry about the delay in reporting this.

--fjZBpNS/k9vJ6kRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj78BYACgkQJNaLcl1U
h9AkyQf/e3e7F7Pk3OKUC6Sce26wTUo8MDGLo0PgSFK+bCCeLWau+ZqDOUr9a5mZ
dge4XBD6WJ1HMCDcU3qLdCXrHwmspyDA/LijDx/TcmChx1qnWYJtT/CfPLoSP9Y4
fs9A6ckI+P3ZO82/4bEwxMu9e0vDsKKOikzoOdZn0O8iTMauwpqbot/if0oMIPPA
ddHn84SkdqyXCjJe8KOEp3cfYIg/D3oa9h/mJJVaJWaz/H8C97jkkZgiob6Xcem3
TzjGQpLtFx8wbERoS6c4NtI3SfCZkBXhBaVEHcAl0/iv56xnedDn/JcCEkIVxqE1
E97DvONInVFwS/6rrs3eTE45VFAeHQ==
=/RTT
-----END PGP SIGNATURE-----

--fjZBpNS/k9vJ6kRK--
