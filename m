Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6C2DC350;
	Mon, 31 Aug 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188761; cv=none; b=UgTLFprUEMw7ZDsksi1zPhlVppD2yo/p2/YNjFk5IAkb6Jj8Dpc8w4fhhE6lsyeoJQXX5Qpz9HbaUL//kpDB284ozeQ5gTEGkQmMEjDkDK8JzIxpFfj+OvJUxxKqNiYZeUTfECZwgt5ZMoSpYq3918sD+PCNX1XlM8lKg/NN6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188761; c=relaxed/simple;
	bh=BDGGItK3Y2cuCahLN1xSaEEaxEmU2S2vFz4MO4pVCNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1A+RXqGeQm7+Pee/DEx131UaQ2GRxyZsmBG/y1NXUx3Eydfl7hmxsT7kTnS4S4SkTGjyG/Qc07McFQzuZuamLvZMztXdA5XEt1O/Dj4abqBo+t7af8Upxopytr8mc0/DRXQV2adlakPY4eqSO+JdC4LqKh/0gxh/Cy4J6Og9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp+OP/kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp+OP/kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4821F000E9;
	Mon, 31 Aug 2026 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188760;
	bh=HO8cmTtR0MakW3g1JFEX5UizaR105ubCT8Daiy7XPXk=;
	h=From:To:Cc:Subject:Date;
	b=Wp+OP/kjX+y16DhSvvDwM3nnnQy/TUHBYfzK7cuJmZ7h60T5ZdDZjAqCqOsr6Wrvi
	 7+t9MaLlU6D9hQQZ4mYnfzT9gXfInmfo6K9AhowZ2bSILQkNMjjYJuDiiVQSOtTUVC
	 e5l8Vin65bUeo0iD7ifMRSQ2u7LM91Hm4TtlhUdbec0pW7nlj9M3smhvHC2KajJAgT
	 VLktMUuoFbXfq427pGfmGRKGoK2PT+Wf3WKKYmbFdMm/DD7RZhDE0rMjFHig2xcbN/
	 4Ex+E1AS9R+Fc5NDfeH67ukokytdpSWfsbJJcR35HfM5hZ0GA1ktx4Pi0/+fKmn1A1
	 czNDPOZ34/cug==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] tracing/probes: Fix BTF structure member finder
Date: Tue,  1 Sep 2026 00:05:54 +0900
Message-ID: <178818875393.104360.1469039168635349344.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

This is a series of fixes for the BTF structure member finder in trace_btf.c
Sashiko found 2 problems in it during reviewing the wprobe series.[1][2]
I decided to pick those fixes as independent fix series.
[1] https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260830143859.D56991F00A3D@smtp.kernel.org/

 - [1/2] btf_find_struct_member() did not consider unnamed bitfields.
   Fix it to skip such unnamed bitfields from nested struct search.
 - [2/2] get_bitoffset_of_field() wrongly checks the field's
   type->kflag for offset encoding. It should check the member's
   type->kflag instead. Thus it adds member_type out-parameter to
   btf_find_struct_member() to get the member's type information
   and use it.

Thanks,

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
      tracing/probes: Fix BTF kflag check for anonymous struct member access


 kernel/trace/trace_btf.c   |   31 +++++++++++++++++--------------
 kernel/trace/trace_btf.h   |    3 ++-
 kernel/trace/trace_probe.c |   15 ++++++++-------
 3 files changed, 27 insertions(+), 22 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
