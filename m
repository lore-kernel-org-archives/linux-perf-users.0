From: Patrick <plafratt@gmail.com>
Subject: L1-dcache-stores twice as big as expected
Date: Thu, 30 Apr 2015 19:37:31 +0000 (UTC)
Message-ID: <loom.20150430T211657-416@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37208 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbbD3TkJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Apr 2015 15:40:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YnuJY-0003vK-Cz
	for linux-perf-users@vger.kernel.org; Thu, 30 Apr 2015 21:40:04 +0200
Received: from masquerade.micron.com ([137.201.242.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2015 21:40:04 +0200
Received: from plafratt by masquerade.micron.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2015 21:40:04 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I have a simple piece of code that I am analyzing with perf:

int main( int argc, char*argv[] ) {
    if( argc < 2 ) {
        cout<<"Error: need size argument.\n";
        return 1;
    }
    uint64_t sz = strtoull( argv[1],NULL,10);
    uint8_t *a;
    a = new uint8_t[sz];

    for(int i=0;i<sz;i++ ) {
        a[i] = 1;
    }
    return 0;
}

When I run perf like this:

-> perf stat -e L1-dcache-stores:u ./copy 1048576

I get the following output:

-> Performance counter stats for './copy 1048576':
->         2,207,859 L1-dcache-stores
->       0.006255441 seconds time elapsed

I can't figure out why it is recording over 2 million stores to the L1 
data cache. I 
would expect it to be around 1 million. Has anyone seen this before?

Any help is appreciated.

Patrick
