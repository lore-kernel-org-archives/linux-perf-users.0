From: Valeri Kuchansky <valeri.kuchansky@genband.com>
Subject: How to assign devices with VT-d in KVM
Date: Wed, 27 Jul 2011 15:47:14 +0000
Message-ID: <28C870B467D2DE46AE9C45B578069D4EE41C@gbplmail03.genband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from exprod7og102.obsmtp.com ([64.18.2.157]:53816 "EHLO
	exprod7og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1G0UV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Jul 2011 16:21:29 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

Folks,

I'm looking for some help on guest network configuration when enabling VT-d.
I have fully completed steps given on http://www.linux-kvm.org/page/How_to_assign_devices_with_VT-d_in_KVM on detaching and assigning VFs to KVM.
I can see Virtual Functions PCIs on the guest. However I cannot find any information on how to further configure to use it by the network service.
The guest  (standard Fedora 15 distro) Network Manager does not recognize any network hardware. 
Any help on this matter would be greatly appreciated. 

Thanks in advance.

Valeri
