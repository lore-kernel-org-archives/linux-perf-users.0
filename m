Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF4331A6B
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706312; cv=none; b=g7opFx45hfEPXY3yU2GVEW/IBBldpif/DFjXd/FT4B4vst5PRjUZAkOix+Tf5W9+WylprPZTzR6k/Kv7VjVSAd952TzZJG7Jbwz1/Og+djx8WU8wOxAM+cpX8O6CiDsK4VSHTz6VfVNIdUYsjIiqdQfw4saiU2aEubuLd6LeONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706312; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ceEPnCNQa0joybnc6dmZWnoYOYjMczA3/vj0yVIsqOu0cEXDvorzd903WEAQJhvjj6fjl6QLQ9Y12IAFlSCf/vxt4/ao/bko5Rbb/R6jyCvVQtwYgk6Jou+fYgE4Oc7WGbpX3NDARpm2uhyLo1CcsrxDnvSvOcDOtUpMzRJ3b/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=tQu+XBeJ reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="tQu+XBeJ"
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id 760AA53386F2
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 07:45:34 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705135; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=tQu+XBeJdFOGvOff7Gv7Dfao5GtC3V+9ZVg4LNSygdo2liV3IXGstufD5Idvt15gFNV/IK
	gfGVsIwoVl7Dw06K4t1yQetzxFEFY4lLsa596sNcRCASkWne2BeHC7i0xnsKgRQQN1Dpvm
	TPIlqq7Kq/jv1HBdKa36J99bFBEhDw9GfJwYAOEhlEuDiB0OuitCcRvDeLHe8rMhLN5xZ0
	BZ5ftkrWjZKrcjK3nS1JFQv+x1hC5b4eISE76ZBGuBAxCh8AxfvunLC+/+MQ1p6nIGY0um
	2FljsP+m9pFRc4G23dVmpfmNKQvRNM8LYKwIrLqjdT/R3SUlHNS04kRKkPtoiQ==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-perf-users@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:33 -0700
Message-ID: <20251017054533.68E692A3948DB90C@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.
