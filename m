From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/9] acpi: Use ACPI C-state type instead of enumeration
 value to export cpuidle state name
Date: Wed, 12 Jan 2011 17:41:34 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101121737170.19754@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
 <201101091330.12027.trenn@suse.de> <alpine.LFD.2.02.1101120130110.19140@x980>
 <201101121333.24240.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <201101121333.24240.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Thomas,

I think the ACPI C-state names are fine the way they are.

I don't understand the value proposition you have presented
to replace the C-state names with ACPI C-state types.

I think this would be extremely confusing, particularly
since it would mean that multiple states can then appear
with duplicate names.

Thus I do not recommend changing the format of the name
that we have been exporting since cpuidle went
upstream 3 years ago.

thanks,
Len Brown, Intel Open Source Technology Center

