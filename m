From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Subject: Re: Tracing kvm: kvm_entry and kvm_exit
Date: Mon, 04 Mar 2013 00:36:11 -0500
Message-ID: <1362375371.513432cbdb150@www.imp.polymtl.ca>
References: <1361550867.51279e13338a7@www.imp.polymtl.ca> <20130225101804.GC2790@stefanha-thinkpad.redhat.com> <512E36B2.5090100@gmail.com> <512EE1D4.6080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <512EE1D4.6080808@gmail.com>
Sender: kvm-owner@vger.kernel.org
To: David Ahern <dsahern@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Selon David Ahern <dsahern@gmail.com>:

> On 2/27/13 9:39 AM, David Ahern wrote:
> > I have been playing with the live mode a bit lately. I'll add a debug to
> > note 2 consecutive entry events without an exit -- see if it sheds some
> > light on it.
>
> If you feel game take this for a spin:
>    https://github.com/dsahern/linux/commits/perf-kvm-live-3.8

Thank you for this, I have been testing it for the last couple of days, I can
see that perf kvm is getting more stable. Though I just realized that if you
launch perf kvm as soon as you start a VM, the VM fails to boot. Any idea why
this happens?

