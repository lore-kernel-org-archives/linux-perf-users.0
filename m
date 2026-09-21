Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3937C911;
	Mon, 21 Sep 2026 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018353; cv=none; b=dvtZ8mKBE2gcGEYyma341Pwovel4cx0hILDAUjbnj9PHX12tmGZbmdyG0BKmqeXbmeR9mcRucQv6aH6135beQcEbWxptd8nv3XGGfhJHehakZeBhcahfkRRh/oCFgqZd1iMVGE1YfMtTAORJUIHDcMI4d/+1QLAmLPEDqqBacPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018353; c=relaxed/simple;
	bh=XdCTTRrzvQ5zUDUwxllo/3JmJD7m/Atdi/LWPDKmLww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KCHDR42B+XU6xmn3vcCcqRoF2BBm7fFVoAKEtodYiAX9N5SKQ6yz8Uvq6tpASK2PZ6SKOADq3BJv5c1OeuOMKbe6GbCDo+d88E0sR0Ne7yVqq6F9gkjxoFxvNnthJkZza/GGt1lbELFPpZyqZ8NNyZQiRi/yfS/ZjvHw3TFyNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9siQ2CX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9siQ2CX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DCB1F000FF;
	Mon, 21 Sep 2026 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018352;
	bh=PNz2iXnGpu185I0AoQKafg4GAIeqJlStnbkZ+VUm3AM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9siQ2CXxlvdVLZCiK0tP0I/yxfXgo7gGzp8CUz8ePA+tEvVkOgnHG+M8vfBBd3pc
	 zzyz7RxCca+R1DwnuZFXrK5wXCc22l3euUAjygjXwUNwsy2Js/mhjNou2Mu6rGAMsW
	 ELkL0eZxGkQqJHu7rIgtqygXaH3YKIYqI1sBf+xEtW8XjEYTKnU0vD+XGvOLEC8gdw
	 eqkErlkiAy/3IyZqexUZPew/Ig76vuSSvgYXPNog7sIKtHr58b4dpiaxLisaEJjObC
	 sFhjXeqoDPPb+UIbqa/wD4ArhWNt/6WE5X3Z2Lot3Cfmw5uVZetT6fcIcMF29selBl
	 OrPZWuULv0Wlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] perf/x86/intel: Invert names of
 intel_ctrl_{guest,host}_mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260921191418.950933-6-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:19:11 +0000
Message-Id: <20260921191911.C7DCB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Rename intel_ctrl_{guest,host}_mask to intel_ctrl_exclude_{host,guest}_ma=
sk
> to more accurately capture what they actually track.  Specifically, an
> event that is excluded from the guest is NOT guaranteed to count in the
> host, and vice versa, as it legal (albeit bizarre) to configure an event =
to
> exclude both the host and the guest, i.e. to not count at all.
>=20
> Subjectively (though anyone who disagrees is wrong), aligning with
> perf_event_attr.exclude_{guest,host} also makes all related code much
> easier to follow.
>=20
> No functional change intended.
>=20
> Suggested-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D5

